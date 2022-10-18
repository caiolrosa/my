use super::{GithubHandler, GithubCommand};

impl GithubHandler {
    pub fn handle(&self) {
        match &self.command {
            GithubCommand::Prs => println!("Github prs command")
        }
    }
}
