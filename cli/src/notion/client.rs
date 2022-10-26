use super::ArchiveTaskPayload;
use anyhow::{Context, Result};
use async_trait::async_trait;

use super::{NotionObject, Page, TaskProperties, CreateTaskProperties, UpdatePage, UpdateTaskProperties, CreatePage, DatabaseFilter};

#[async_trait]
pub trait NotionClient {
    async fn query_database(&self, database_id: &str, filter: Option<DatabaseFilter>) -> Result<NotionObject<Page<TaskProperties>>>;
    async fn create_task_page(&self, page: CreatePage<CreateTaskProperties>) -> Result<Page<TaskProperties>>;
    async fn update_task_page(&self, page_id: String, page: UpdatePage<UpdateTaskProperties>) -> Result<Page<TaskProperties>>;
    async fn archive_task_page(&self, page_id: String, payload: ArchiveTaskPayload) -> Result<Page<TaskProperties>>;
}

pub struct NotionClientImpl {
    notion_api_version: String,
    notion_token: String
}

impl NotionClientImpl {
    pub fn new(notion_api_version: String, notion_token: String) -> NotionClientImpl {
        NotionClientImpl { notion_api_version, notion_token }
    }

    fn build_url(&self, endpoint: &str) -> String {
        format!("https://api.notion.com/v1{}", endpoint)
    }

    fn build_request(&self, builder: reqwest::RequestBuilder) -> reqwest::RequestBuilder {
        builder
            .header("Notion-Version", self.notion_api_version.to_string())
            .header("Content-Type", "application/json")
            .bearer_auth(&self.notion_token)
    }
}

#[async_trait]
impl NotionClient for NotionClientImpl {
    async fn query_database(&self, database_id: &str, filter: Option<DatabaseFilter>) -> Result<NotionObject<Page<TaskProperties>>> {
        let client = reqwest::Client::new();

        let mut req = client.post(self.build_url(format!("/databases/{}/query", database_id).as_str()));
        if let Some(f) = &filter {
            req = req.json(&f)
        }

        self.build_request(req)
            .send()
            .await
            .with_context(|| "Failed to query notion database")?
            .json::<NotionObject<Page<TaskProperties>>>()
            .await
            .with_context(|| "Failed to parse notion query database response")
    }

    async fn create_task_page(&self, page: CreatePage<CreateTaskProperties>) -> Result<Page<TaskProperties>> {
        let client = reqwest::Client::new();
        let req = client.post(self.build_url("/pages"));

        self
            .build_request(req)
            .json(&page)
            .send()
            .await
            .with_context(|| format!("Failed to create page in database {}", page.parent.database_id))?
            .json::<Page<TaskProperties>>()
            .await
            .with_context(|| "Failed to parse notion created task page")
    }

    async fn update_task_page(&self, page_id: String, page: UpdatePage<UpdateTaskProperties>) -> Result<Page<TaskProperties>> {
        let client = reqwest::Client::new();
        let req = client.patch(self.build_url(format!("/pages/{}", page_id).as_str()));

        self
            .build_request(req)
            .json(&page)
            .send()
            .await
            .with_context(|| "Failed to update page in database")?
            .json::<Page<TaskProperties>>()
            .await
            .with_context(|| "Failed to parse notion updated task page")
    }

    async fn archive_task_page(&self, page_id: String, payload: ArchiveTaskPayload) -> Result<Page<TaskProperties>> {
        let client = reqwest::Client::new();
        let req = client.patch(self.build_url(format!("/pages/{}", page_id).as_str()));

        self
            .build_request(req)
            .json(&payload)
            .send()
            .await
            .with_context(|| "Failed to update page in database")?
            .json::<Page<TaskProperties>>()
            .await
            .with_context(|| "Failed to parse notion updated task page")
    }
}
