use crate::cmd::CommandHandler;

use super::{CalendarHandler, CalendarCommand};

impl CommandHandler for CalendarHandler {
    fn handle(&self) {
        match &self.command {
            CalendarCommand::List => println!("Calendar list command"),
            CalendarCommand::Sync => println!("Calendar sync command"),
        }
    }
}
