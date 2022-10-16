pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum GithubCommand {
    Prs,
}

#[derive(Parser)]
pub struct GithubHandler {
    #[command(subcommand)]
    command: GithubCommand
}

