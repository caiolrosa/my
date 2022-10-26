pub mod service;

use serde::{Serialize, Deserialize};
use anyhow::Result;

use crate::notion;

#[derive(Serialize, Deserialize)]
pub struct Notion {
    pub api_version: String,
    pub task_database_id: String,
}

#[derive(Serialize, Deserialize)]
pub struct Config {
    pub notion: Notion
}

impl Config {
    pub fn default() -> Config {
        Config {
            notion: Notion {
                api_version: notion::default_api_version(),
                task_database_id: "[add your task database id here]".to_string()
            }
        }
    }
}

pub trait ConfigService {
    fn load_config(&self) -> Result<Config>;
    fn edit_config(&self, config: Option<&Config>) -> Result<Config>;
}

pub struct ConfigServiceImpl;
