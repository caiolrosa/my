pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum CalendarCommand {
    /// List all items in the calendar
    List,

    /// Syncronize calendar across all registered accounts
    Sync,
}

#[derive(Parser)]
pub struct CalendarHandler {
    #[command(subcommand)]
    command: CalendarCommand
}

