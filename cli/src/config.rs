use std::{fs::{File, self}, io::{Write, Read}, path::PathBuf};

use anyhow::{Result, anyhow, Context};
use dialoguer::{Input, theme::ColorfulTheme};
use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
pub struct Notion {
    pub task_database_id: String
}

#[derive(Serialize, Deserialize)]
pub struct Config {
    pub notion: Notion
}

impl Config {
    pub fn new(task_database_id: String) -> Config {
        Config { notion: Notion { task_database_id } }
    }
}

fn prompt_config_setup() -> Result<Config> {
    let theme = ColorfulTheme::default();
    let task_database_id = Input::with_theme(&theme)
        .with_prompt("Notion task database id")
        .interact()
        .with_context(|| "Failed reading user notion task database id input")?;
    
    Ok(Config::new(task_database_id))
}

fn init_config(config_file: &PathBuf) -> Result<Config> {
    println!("Config file not found at ({}), please follow the instructions below", config_file.to_str().unwrap_or("Directory not found"));
    fs::create_dir_all(config_file.parent().ok_or_else(|| anyhow!("Failed getting config file parent directory"))?)?;

    let config = prompt_config_setup()?;
    let mut file = File::create(config_file)?;
    let serialized_config = toml::to_string(&config)?;
    if file.write(serialized_config.as_bytes())? != serialized_config.as_bytes().len() {
        return Err(anyhow!("Failed to write user config file"))
    }

    Ok(config)
}

pub fn load_config() -> Result<Config> {
    let config_dir = dirs::home_dir().ok_or_else(|| anyhow!("Failed to locate user's config directory"))?;
    let cli_config = config_dir.join(".config").join("my").join("config.toml");

    match cli_config.try_exists() {
        Ok(exists) => {
            if exists {
                let mut file = File::open(cli_config)?;
                let mut config_string = String::new();
                file.read_to_string(&mut config_string)?;

                return toml::from_str::<Config>(&config_string).with_context(|| "Failed to parse user config")
            }

            init_config(&cli_config)
        },
        Err(_) => init_config(&cli_config)
    }
}
