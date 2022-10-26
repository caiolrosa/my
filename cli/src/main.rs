mod cmd;
mod notion;
mod config;

use crate::notion::service::NotionServiceImpl;
use std::env;

use crate::cmd::task::TaskHandler;
use anyhow::{Result, Context};
use clap::{Parser, Subcommand};
use cmd::github::GithubHandler;
use dialoguer::{theme::ColorfulTheme, Password};
use notion::client::NotionClientImpl;

#[derive(Subcommand)]
enum RootCommand {
    /// Interact with CLI generated tasks and view tasks from any source
    Task(TaskHandler),

    /// Interact with github resources
    Github(GithubHandler),
}

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: RootCommand
}

fn secret_request(message: &str) -> Result<String> {
    Password::with_theme(&ColorfulTheme::default()).with_prompt(message).interact().with_context(|| "Failed getting user information")
}

fn notion_token() -> Result<String> {
    let service = "notion";
    let username = "my_cli";
    let entry = keyring::Entry::new(service, username);

    match entry.get_password() {
        Ok(p) => Ok(p),
        Err(_) => {
            if let Ok(t) = env::var("NOTION_API_TOKEN") {
                return Ok(t)
            }

            let notion_token = secret_request("Notion API Token")?;
            entry.set_password(&notion_token)?;

            entry.get_password().with_context(|| "Failed to retrieve notion token")
        },
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    let token = notion_token()?;
    let config = config::load_config()?;

    match &cli.command {
        RootCommand::Task(handler) => {
            let notion_client = NotionClientImpl::new(token);
            let notion_service = NotionServiceImpl::new(Box::new(notion_client), config.notion.task_database_id.to_string());

            handler.handle(notion_service).await?;
        }
        RootCommand::Github(handler) => handler.handle(),
    }

    Ok(())
}
