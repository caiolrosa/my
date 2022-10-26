use std::path::Path;
use crate::config::{Config, ConfigServiceImpl, ConfigService};
use crate::notion;
use std::{fs::{File, self}, io::{Write, Read}, path::PathBuf};

use anyhow::{Result, anyhow, Context};
use dialoguer::{Input, theme::ColorfulTheme};

impl ConfigServiceImpl {
    pub fn new() -> ConfigServiceImpl {
        ConfigServiceImpl {}
    }

    fn prompt_config_setup(&self) -> Result<Config> {
        let theme = ColorfulTheme::default();
        let task_database_id = Input::with_theme(&theme)
            .with_prompt("Notion task database id")
            .interact()
            .with_context(|| "Failed to read user notion task database id input")?;

        let notion_version = Input::with_theme(&theme)
            .with_prompt("Notion API version")
            .with_initial_text(&notion::default_api_version())
            .interact_text()
            .with_context(|| "Failed to read notion api version input")?;
        
        Ok(Config::new(notion_version, task_database_id))
    }

    fn init_config(&self, config_file: &Path) -> Result<Config> {
        println!("Config file not found at ({}), please follow the instructions below", config_file.to_str().unwrap_or("Directory not found"));
        fs::create_dir_all(config_file.parent().ok_or_else(|| anyhow!("Failed getting config file parent directory"))?)?;

        let config = self.prompt_config_setup()?;
        self.save_config(config)
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

    fn save_config(&self, config: Config) -> Result<Config> {
        let file_path = self.config_file_path()?;
        let mut file = File::create(file_path)?;
        let serialized_config = toml::to_string(&config)?;
        if file.write(serialized_config.as_bytes())? != serialized_config.as_bytes().len() {
            return Err(anyhow!("Failed to write user config file"))
        }

        Ok(config)
    }
}

