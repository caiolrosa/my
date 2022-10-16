pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum TaskCommand {
    List,
    Create,
    Update,
    Delete,
    Sync,
}

#[derive(Parser)]
pub struct TaskHandler {
    #[command(subcommand)]
    command: TaskCommand
}

