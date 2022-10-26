pub mod handler;

use clap::{Parser, Subcommand};

#[derive(Subcommand)]
enum ConfigCommand {
    /// Edit cli configuration file
    Edit
}

#[derive(Parser)]
pub struct ConfigHandler {
    #[command(subcommand)]
    command: ConfigCommand,
}

