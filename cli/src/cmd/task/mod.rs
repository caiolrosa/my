pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum TaskCommand {
    List,
    Create,
    Update,
    Delete,
    Complete,
}

#[derive(Parser)]
pub struct TaskHandler {
    #[command(subcommand)]
    command: TaskCommand
}

