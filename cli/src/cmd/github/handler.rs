use crate::cmd::CommandHandler;

use super::{GithubHandler, GithubCommand};

impl CommandHandler for GithubHandler {
    fn handle(&self) {
        match &self.command {
            GithubCommand::Prs => println!("Github prs command")
        }
    }
}
