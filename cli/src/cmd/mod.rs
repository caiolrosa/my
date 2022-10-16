pub mod task;
pub mod calendar;
pub mod github;

pub trait CommandHandler {
    fn handle(&self);
}
