use std::str::FromStr;

use anyhow::{Context, Result, anyhow};
use serde::Deserialize;

#[derive(Deserialize)]
pub struct Text {
    pub plain_text: String
}

#[derive(Deserialize)]
pub struct Title {
    pub title: Vec<Text>
}

#[derive(Deserialize)]
pub struct RichText {
    pub rich_text: Vec<Text>
}

#[derive(Deserialize)]
pub struct Selection {
    pub name: String
}

#[derive(Deserialize)]
pub struct Select {
    pub select: Selection
}

#[derive(Deserialize)]
pub struct Status {
    pub status: Selection
}

#[derive(Deserialize)]
pub struct CreatedAt {
    pub created_time: String
}

#[derive(Deserialize)]
pub struct UpdatedAt {
    pub last_edited_time: String
}

#[derive(Deserialize)]
pub struct TaskDatabaseProperties {
    pub id: RichText,
    pub source_id: RichText,
    pub source: Select,
    pub text: Title,
    pub status: Status,
    pub created_at: CreatedAt,
    pub updated_at: UpdatedAt,
}

#[derive(Deserialize)]
pub struct TaskDatabaseResults {
    pub properties: TaskDatabaseProperties
}

#[derive(Deserialize)]
pub struct QueryTaskDatabase {
    pub results: Vec<TaskDatabaseResults>
}

#[derive(Debug, Deserialize)]
pub enum TaskSource {
    #[serde(rename = "cli")]
    Cli,

    #[serde(rename = "jira")]
    Jira,
}

#[derive(Debug, Deserialize)]
pub enum TaskStatus {
    #[serde(rename = "not_started")]
    NotStarted,

    #[serde(rename = "in_progress")]
    InProgress,

    #[serde(rename = "done")]
    Done,
}

#[derive(Debug)]
pub struct Task {
    pub id: String,
    pub source_id: String,
    pub source: TaskSource,
    pub text: String,
    pub status: TaskStatus,
    pub created_at: String,
    pub updated_at: String,
}

impl FromStr for TaskStatus {
    type Err = anyhow::Error; 

    fn from_str(status: &str) -> Result<Self, Self::Err> {
        match status {
            "not_started" => Ok(TaskStatus::NotStarted),
            "in_progress" => Ok(TaskStatus::NotStarted),
            "done" => Ok(TaskStatus::NotStarted),
            _ => Err(anyhow!("Task status not found"))
        }
    }
}

impl FromStr for TaskSource {
    type Err = anyhow::Error;

    fn from_str(source: &str) -> Result<Self, Self::Err> {
        match source {
            "cli" => Ok(TaskSource::Cli),
            "jira" => Ok(TaskSource::Jira),
            _ => Err(anyhow!("Failed to parse task source")),
        }
    }
}

impl TryFrom<TaskDatabaseProperties> for Task {
    type Error = anyhow::Error;

    fn try_from(props: TaskDatabaseProperties) -> Result<Self, Self::Error> {
        Ok(Task {
            id: props.id.rich_text.first().with_context(|| "Task missing id property")?.plain_text.to_string(),
            source_id: props.source_id.rich_text.first().with_context(|| "Task missing source id property")?.plain_text.to_string(),
            source: TaskSource::from_str(props.source.select.name.as_str())?,
            text: props.text.title.first().with_context(|| "Task missing text property")?.plain_text.to_string(),
            status: TaskStatus::from_str(props.status.status.name.as_str())?,
            created_at: props.created_at.created_time,
            updated_at: props.updated_at.last_edited_time,
        })
    }
}
