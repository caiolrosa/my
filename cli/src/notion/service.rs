use super::CreatePage;
use super::{client::NotionClient, Task, CreateTaskPayload, UpdateTaskPayload, UpdatePage, ArchiveTaskPayload, DatabaseFilter, SelectFilter};
use anyhow::Result;
use async_trait::async_trait;

#[async_trait]
pub trait NotionService {
    async fn list_tasks(&self, filter: Option<DatabaseFilter<SelectFilter>>) -> Result<Vec<Task>>;
    async fn create_task(&self, database_id: String, payload: CreateTaskPayload) -> Result<Task>;
    async fn update_task(&self, page_id: String, archived: bool, payload: UpdateTaskPayload) -> Result<Task>;
    async fn archive_task(&self, page_id: String) -> Result<Task>;
    async fn start_task(&self, task: Task) -> Result<Task>;
    async fn complete_task(&self, task: Task) -> Result<Task>;
}

pub struct NotionServiceImpl {
    notion_client: Box<dyn NotionClient + Send + Sync>,
    database_id: String,
}

impl NotionServiceImpl {
    pub fn new(notion_client: Box<dyn NotionClient + Send + Sync>, database_id: String) -> NotionServiceImpl {
        NotionServiceImpl {
            notion_client,
            database_id,
        }
    }
}

#[async_trait]
impl NotionService for NotionServiceImpl {
    async fn list_tasks(&self, filter: Option<DatabaseFilter<SelectFilter>>) -> Result<Vec<Task>> {
        let query_result = self.notion_client.query_database(&self.database_id, filter).await?;

        query_result.results.into_iter().map(Task::try_from).collect()
    }

    async fn create_task(&self, database_id: String, payload: CreateTaskPayload) -> Result<Task> {
        let task_properties = payload.into();
        let task_page = CreatePage::new(database_id, task_properties);

        self.notion_client.create_task_page(task_page).await?.try_into()
    }

    async fn update_task(&self, page_id: String, archived: bool, payload: UpdateTaskPayload) -> Result<Task> {
        let task_properties = payload.into();
        let task_page = UpdatePage::new(archived, task_properties);

        self.notion_client.update_task_page(page_id, task_page).await?.try_into()
    }

    async fn archive_task(&self, page_id: String) -> Result<Task> {
        let payload = ArchiveTaskPayload::new(true);

        self.notion_client.archive_task_page(page_id, payload).await?.try_into()
    }

    async fn start_task(&self, mut task: Task) -> Result<Task> {
        task.start();

        self.update_task(task.notion_page_id().into(), false, task.into()).await
    }

    async fn complete_task(&self, mut task: Task) -> Result<Task> {
        task.complete();

        self.update_task(task.notion_page_id().into(), false, task.into()).await
    }
}
