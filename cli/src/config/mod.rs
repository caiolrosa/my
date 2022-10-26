pub mod service;

use serde::{Serialize, Deserialize};
use anyhow::Result;

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
    pub fn new(api_version: String, task_database_id: String) -> Config {
        Config { notion: Notion { api_version, task_database_id } }
    }
}

pub trait ConfigService {
    fn load_config(&self) -> Result<Config>;
    fn save_config(&self, config: Config) -> Result<Config>;
}

pub struct ConfigServiceImpl;
