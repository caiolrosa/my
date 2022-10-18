use super::{CalendarHandler, CalendarCommand};

impl CalendarHandler {
    pub fn handle(&self) {
        match &self.command {
            CalendarCommand::List => println!("Calendar list command"),
            CalendarCommand::Sync => println!("Calendar sync command"),
        }
    }
}
