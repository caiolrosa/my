use crate::cmd::{task::TaskHandler, task::TaskCommand, CommandHandler};

impl CommandHandler for TaskHandler {
    fn handle(&self) {
        match &self.command {
            TaskCommand::List => println!("Task list command"),
            TaskCommand::Create => println!("Task create command"),
            TaskCommand::Update => println!("Task update command"),
            TaskCommand::Delete => println!("Task delete command"),
            TaskCommand::Sync => println!("Task sync command"),
        }
    }
}
