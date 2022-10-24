pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum TaskCommand {
    /// List tasks
    List,

    /// Create a task (the source will always be CLI)
    Create,

    /// Update a CLI created task
    Update,

    /// Delete a CLI created task
    Delete,

    /// Complete a CLI created task
    Complete,
}

#[derive(Parser)]
pub struct TaskHandler {
    #[command(subcommand)]
    command: TaskCommand
}

