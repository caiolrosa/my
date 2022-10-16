pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum CalendarCommand {
    List,
    Sync,
}

#[derive(Parser)]
pub struct CalendarHandler {
    #[command(subcommand)]
    command: CalendarCommand
}

