pub mod handler;

use clap::{Parser, Subcommand};

use crate::notion::{TaskStatus, TaskSource};

#[derive(Subcommand)]
enum TaskCommand {
    /// List tasks
    List {
        #[arg(long)]
        status: Option<TaskStatus>,

        #[arg(long)]
        source: Option<TaskSource>,
    },

    /// Create a task (the source will always be CLI)
    Create,

    /// Update a CLI created task
    Update,

    /// Delete a CLI created task
    Delete,

    /// Start a CLI created task
    Start,

    /// Complete a CLI created task
    Complete,
}

#[derive(Parser)]
pub struct TaskHandler {
    #[command(subcommand)]
    command: TaskCommand,
}

