pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum GithubCommand {
    /// View a list of opened pull requests
    Prs,
}

#[derive(Parser)]
pub struct GithubHandler {
    #[command(subcommand)]
    command: GithubCommand
}

