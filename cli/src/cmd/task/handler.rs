use crate::cmd::task::{TaskHandler, TaskCommand};

use crate::notion::model::{CreateTask, TaskSource, TaskStatus};
use crate::notion::service::NotionService;

impl TaskHandler {
    pub async fn handle(&self, task_service: impl NotionService) {
        match &self.command {
            TaskCommand::List => println!("{:?}", task_service.list_tasks().await.unwrap()),
            TaskCommand::Create => {
                let database_id = "c0ce71a3-47f3-4f6d-8145-b6d1aaf190e4".into();
                let payload = CreateTask::new("asdqwe1-fa13-sgsr-i312-dfgpsfgspdfuh".into(), TaskSource::Jira, "jira task".into(), TaskStatus::Done);
                println!("{:?}", task_service.create_task(database_id, payload).await.unwrap())
            },
            TaskCommand::Update => println!("{:?}", task_service.list_tasks().await.unwrap()),
            TaskCommand::Delete => println!("{:?}", task_service.list_tasks().await.unwrap()),
            TaskCommand::Sync => println!("{:?}", task_service.list_tasks().await.unwrap()),
        };
    }
}
