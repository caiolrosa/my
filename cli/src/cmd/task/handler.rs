use std::str::FromStr;
use crate::notion::{SelectFilter, UpdateTaskPayload};
use anyhow::Result;
use dialoguer::{Input, FuzzySelect};
use dialoguer::theme::ColorfulTheme;
use strum::VariantNames;
use uuid::Uuid;
use anyhow::anyhow;

use crate::cmd::task::{TaskHandler, TaskCommand};

use crate::notion::{CreateTaskPayload, TaskSource, TaskStatus, DatabaseFilter};
use crate::notion::service::NotionService;

impl TaskHandler {
    pub async fn handle(&self, task_service: impl NotionService) -> Result<()> {
        match &self.command {
            TaskCommand::List => list_task(&task_service).await?,
            TaskCommand::Create => create_task(&task_service).await?,
            TaskCommand::Update => update_task(&task_service).await?,
            TaskCommand::Delete => delete_task(&task_service).await?,
            TaskCommand::Start => start_task(&task_service).await?,
            TaskCommand::Complete => complete_task(&task_service).await?,
        };

        Ok(())
    }
}

async fn list_task(task_service: &impl NotionService) -> Result<()> {
    let tasks = task_service.list_tasks(None).await?;

    for task in tasks  {
        println!("{: <4} | {: <11} | {}", task.source, task.status, task.text)
    }

    Ok(())
}

async fn create_task(task_service: &impl NotionService) -> Result<()> {
    let text = Input::with_theme(&ColorfulTheme::default()).with_prompt("Task title").interact_text()?;

    let uuid = Uuid::new_v4();
    let create_payload = CreateTaskPayload::new(uuid.to_string(), TaskSource::Cli, text, TaskStatus::NotStarted);
    let created_task = task_service.create_task(create_payload).await?;

    println!("[created] {} | {}", created_task.status, created_task.text);

    Ok(())
}

async fn update_task(task_service: &impl NotionService) -> Result<()> {
    let theme = ColorfulTheme::default();
    let filter = DatabaseFilter::<SelectFilter>::build_select_filter("source".into(), TaskSource::Cli.to_string());
    let tasks = task_service.list_tasks(Some(filter)).await?;

    let select_items: Vec<String> = tasks.iter().map(|t| format!("{} | {}", t.status, t.text)).collect();
    let selected_task_index = FuzzySelect::with_theme(&theme).with_prompt("Select task to edit").items(&select_items).interact()?;
    let text: String = Input::with_theme(&theme).with_prompt("Task text").with_initial_text(&tasks[selected_task_index].text).interact_text()?;
    let selected_status_index = FuzzySelect::with_theme(&theme).with_prompt("Select task status").items(TaskStatus::VARIANTS).interact()?;

    let update_payload = UpdateTaskPayload::new(
        TaskSource::Cli,
        text,
        TaskStatus::from_str(TaskStatus::VARIANTS[selected_status_index])?,
    );

    let updated_task = task_service.update_task(tasks[selected_task_index].notion_page_id().into(), false, update_payload).await?;

    println!("[updated] {} | {}", updated_task.status, updated_task.text);

    Ok(())
}

async fn delete_task(task_service: &impl NotionService) -> Result<()> {
    let theme = ColorfulTheme::default();
    let filter = DatabaseFilter::<SelectFilter>::build_select_filter("source".into(), TaskSource::Cli.to_string());
    let tasks = task_service.list_tasks(Some(filter)).await?;

    let select_items: Vec<String> = tasks.iter().map(|t| format!("{} | {}", t.status, t.text)).collect();
    let selected_task_index = FuzzySelect::with_theme(&theme).with_prompt("Select task to edit").items(&select_items).interact()?;

    let deleted_task = task_service.archive_task(tasks[selected_task_index].notion_page_id().into()).await?;

    println!("[deleted] {} | {}", deleted_task.status, deleted_task.text);

    Ok(())
}

async fn start_task(task_service: &impl NotionService) -> Result<()> {
    let theme = ColorfulTheme::default();
    let filter = DatabaseFilter::<SelectFilter>::build_select_filter("source".into(), TaskSource::Cli.to_string());
    let tasks = task_service.list_tasks(Some(filter)).await?;

    let select_items: Vec<String> = tasks.iter().map(|t| format!("{} | {}", t.status, t.text)).collect();
    let selected_task_index = FuzzySelect::with_theme(&theme).with_prompt("Select task to start").items(&select_items).interact()?;

    let selected_task = tasks.into_iter().nth(selected_task_index).ok_or_else(|| anyhow!("Invalid chosen task index"))?;
    let completed_task = task_service.start_task(selected_task).await?;

    println!("[started] {} | {}", completed_task.status, completed_task.text);

    Ok(())
}

async fn complete_task(task_service: &impl NotionService) -> Result<()> {
    let theme = ColorfulTheme::default();
    let filter = DatabaseFilter::<SelectFilter>::build_select_filter("source".into(), TaskSource::Cli.to_string());
    let tasks = task_service.list_tasks(Some(filter)).await?;

    let select_items: Vec<String> = tasks.iter().map(|t| format!("{} | {}", t.status, t.text)).collect();
    let selected_task_index = FuzzySelect::with_theme(&theme).with_prompt("Select task to complete").items(&select_items).interact()?;

    let selected_task = tasks.into_iter().nth(selected_task_index).ok_or_else(|| anyhow!("Invalid chosen task index"))?;
    let completed_task = task_service.complete_task(selected_task).await?;

    println!("[completed] {} | {}", completed_task.status, completed_task.text);

    Ok(())
}
