use std::path::Path;
use crate::config::{Config, ConfigServiceImpl, ConfigService};
use std::{fs::{File, self}, io::{Write, Read}, path::PathBuf};

use anyhow::{Result, anyhow, Context};
use dialoguer::Editor;

impl ConfigServiceImpl {
    pub fn new() -> ConfigServiceImpl {
        ConfigServiceImpl {}
    }

    fn init_config(&self, config_file: &Path) -> Result<Config> {
        println!("Config file not found at ({}), please follow the instructions below", config_file.to_str().unwrap_or("Directory not found"));
        fs::create_dir_all(config_file.parent().ok_or_else(|| anyhow!("Failed getting config file parent directory"))?)?;

        self.edit_config(None)
    }

    fn config_file_path(&self) -> Result<PathBuf> {
        let config_dir = dirs::home_dir().ok_or_else(|| anyhow!("Failed to locate user's config directory"))?;
        Ok(config_dir.join(".config").join("my").join("config.toml"))
    }
}

impl ConfigService for ConfigServiceImpl {
    fn load_config(&self) -> Result<Config> {
        let cli_config = self.config_file_path()?;

        match cli_config.try_exists() {
            Ok(exists) => {
                if exists {
                    let mut file = File::open(cli_config)?;
                    let mut config_string = String::new();
                    file.read_to_string(&mut config_string)?;

                    return toml::from_str::<Config>(&config_string).with_context(|| "Failed to parse user config")
                }

                self.init_config(&cli_config)
            },
            Err(_) => self.init_config(&cli_config)
        }
    }

    fn edit_config(&self, config: Option<&Config>) -> Result<Config> {
        let file_path = self.config_file_path()?;
        let mut file = File::create(file_path)?;

        let default_config = Config::default();
        let editable_config = config.unwrap_or(&default_config);
        let serialized_editable_config = toml::to_string(&editable_config)?;

        let edited_config_text = Editor::new().edit(&serialized_editable_config)?.ok_or_else(|| anyhow!("Failed to edit config file or operation was canceled"))?;
        let edited_config = toml::from_str::<Config>(&edited_config_text)?;
        if file.write(edited_config_text.as_bytes())? != edited_config_text.as_bytes().len() {
            return Err(anyhow!("Failed to write user config file"))
        }

        Ok(edited_config)
    }
}

