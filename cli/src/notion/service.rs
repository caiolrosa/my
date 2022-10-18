use super::{client::NotionClient, model::Task};
use anyhow::Result;
use async_trait::async_trait;

#[async_trait]
pub trait NotionService {
    async fn list_tasks(&self) -> Result<Vec<Task>>;
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
}
