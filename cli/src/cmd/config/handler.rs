use anyhow::{Result, Context, anyhow};
use dialoguer::Editor;
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
    let serialized_config = toml::to_string(config)?;
    let edited_config_text = Editor::new().edit(&serialized_config)?.ok_or_else(|| anyhow!("Failed to edit config or operation was canceled"))?;
    let edited_config = toml::from_str::<Config>(&edited_config_text).with_context(|| "Failed to parse edited config file")?;

    config_service.save_config(edited_config)?;

    println!("Config edited successfully");

    Ok(())
}
