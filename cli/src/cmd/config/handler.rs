use anyhow::Result;
use super::{ConfigHandler, ConfigCommand};
use crate::config::{Config, ConfigService};

impl ConfigHandler {
    pub fn handle(&self, config_service: &impl ConfigService, config: &Config) -> Result<()> {
        match &self.command {
            ConfigCommand::Edit => edit_config(config_service, config)
        }
    }
}

fn edit_config(config_service: &impl ConfigService, config: &Config) -> Result<()> {
    config_service.edit_config(Some(config))?;

    println!("Config edited successfully");

    Ok(())
}
