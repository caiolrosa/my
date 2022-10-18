use anyhow::{Context, Result};
use async_trait::async_trait;

use super::model::QueryTaskDatabase;

#[async_trait]
pub trait NotionClient {
    async fn query_database(&self, database_id: &str) -> Result<QueryTaskDatabase>;
}

pub struct NotionClientImpl {
    notion_token: String
}

impl NotionClientImpl {
    pub fn new(notion_token: String) -> NotionClientImpl {
        NotionClientImpl {
            notion_token
        }
    }

    fn build_url(&self, endpoint: &str) -> String {
        format!("https://api.notion.com/v1{}", endpoint)
    }

    fn build_request(&self, builder: reqwest::RequestBuilder) -> reqwest::RequestBuilder {
        builder
            .header("Notion-Version", "2022-06-28")
            .header("Content-Type", "application/json")
            .bearer_auth(&self.notion_token)
    }
}

#[async_trait]
impl NotionClient for NotionClientImpl {
    async fn query_database(&self, database_id: &str) -> Result<QueryTaskDatabase> {
        let client = reqwest::Client::new();
        let req = client.post(self.build_url(format!("/databases/{}/query", database_id).as_str()));

        self
            .build_request(req)
            .send()
            .await
            .with_context(|| "Failed to query notion database")?
            .json::<QueryTaskDatabase>()
            .await
            .with_context(|| "Failed to parse notion query database response")
    }
}
