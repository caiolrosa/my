use crate::notion::model::Page;
use super::{client::NotionClient, model::{Task, CreateTask, CreateTaskProperties}};
use anyhow::Result;
use async_trait::async_trait;

#[async_trait]
pub trait NotionService {
    async fn list_tasks(&self) -> Result<Vec<Task>>;
    async fn create_task(&self, database_id: String, payload: CreateTask) -> Result<Task>;
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
    async fn list_tasks(&self) -> Result<Vec<Task>> {
        let query_result = self.notion_client.query_database(&self.database_id).await?;

        query_result.results.into_iter().map(|r| Task::try_from(r.properties)).collect()
    }

    async fn create_task(&self, database_id: String, payload: CreateTask) -> Result<Task> {
        let task_properties = CreateTaskProperties::new(payload);
        let task_page = Page::new(database_id, task_properties);

        self.notion_client.create_task_page(task_page).await?.properties.try_into()
    }
}
