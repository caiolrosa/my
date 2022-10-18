use crate::cmd::task::{TaskHandler, TaskCommand};

use crate::notion::service::NotionService;

impl TaskHandler {
    pub async fn handle(&self, task_service: impl NotionService) {
        let list = match &self.command {
            TaskCommand::List => task_service.list_tasks().await.unwrap(),
            TaskCommand::Create => task_service.list_tasks().await.unwrap(),
            TaskCommand::Update => task_service.list_tasks().await.unwrap(),
            TaskCommand::Delete => task_service.list_tasks().await.unwrap(),
            TaskCommand::Sync => task_service.list_tasks().await.unwrap(),
        };

        println!("{:?}", list)
    }
}
