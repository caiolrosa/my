mod cmd;
mod notion;

use crate::notion::service::NotionServiceImpl;
use std::env;

use crate::cmd::task::TaskHandler;
use clap::{Parser, Subcommand};
use cmd::{calendar::CalendarHandler, github::GithubHandler};
use notion::client::NotionClientImpl;

#[derive(Subcommand)]
enum RootCommand {
    /// Interact with CLI generated tasks and view tasks from any source
    Task(TaskHandler),

    /// Interact and syncronize calendar information
    Calendar(CalendarHandler),

    /// Interact with github resources
    Github(GithubHandler),
}

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: RootCommand
}

fn notion_token() -> Result<String, env::VarError> {
    env::var("NOTION_API_TOKEN")
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    let token = notion_token().expect("Failed to load notion api token, please make sure to add it to your keyring");

    match &cli.command {
        RootCommand::Task(handler) => {
            let task_database_id = "c0ce71a3-47f3-4f6d-8145-b6d1aaf190e4";
            let notion_client = NotionClientImpl::new(token);
            let notion_service = NotionServiceImpl::new(Box::new(notion_client), task_database_id.to_string());

            handler.handle(notion_service).await?;
        }
        RootCommand::Calendar(handler) => handler.handle(),
        RootCommand::Github(handler) => handler.handle(),
    }

    Ok(())
}
