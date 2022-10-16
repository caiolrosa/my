mod cmd;

use crate::cmd::task::TaskHandler;
use clap::{Parser, Subcommand};
use cmd::{CommandHandler, calendar::CalendarHandler, github::GithubHandler};

#[derive(Subcommand)]
enum RootCommand {
    Task(TaskHandler),
    Calendar(CalendarHandler),
    Github(GithubHandler),
}

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: RootCommand
}

fn main() {
    let cli = Cli::parse();

    match &cli.command {
        RootCommand::Task(handler) => handler.handle(),
        RootCommand::Calendar(handler) => handler.handle(),
        RootCommand::Github(handler) => handler.handle(),
    }
}
