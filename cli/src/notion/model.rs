use std::str::FromStr;

use anyhow::{Context, Result, anyhow};
use serde::Deserialize;

#[derive(Deserialize)]
pub struct Text {
    pub content: String
}

#[derive(Deserialize)]
pub struct RichText {
    pub text: Text
}

#[derive(Deserialize)]
pub struct RichTextProperty {
    pub rich_text: Vec<RichText>
}

#[derive(Deserialize)]
pub struct Select {
    pub name: String
}

#[derive(Deserialize)]
pub struct SelectProperty {
    pub select: Select
}

#[derive(Deserialize)]
pub struct Title {
    pub text: Text
}

#[derive(Deserialize)]
pub struct TitleProperty {
    pub title: Vec<Title>
}

#[derive(Deserialize)]
pub struct Status {
    pub name: String
}

#[derive(Deserialize)]
pub struct StatusProperty {
    pub status: Select
}

#[derive(Deserialize)]
pub struct CreatedAtProperty {
    pub created_time: String
}

#[derive(Deserialize)]
pub struct UpdatedAtProperty {
    pub last_edited_time: String
}

#[derive(Deserialize)]
pub struct TaskProperties {
    pub id: RichTextProperty,
    pub source_id: RichTextProperty,
    pub source: SelectProperty,
    pub text: TitleProperty,
    pub status: StatusProperty,
    pub created_at: CreatedAtProperty,
    pub updated_at: UpdatedAtProperty
}

#[derive(Deserialize)]
pub struct Parent {
    #[serde(rename = "type")]
    pub parent_type: String,

    pub database_id: String
}

#[derive(Deserialize)]
pub struct Page<T> {
    pub parent: Parent,
    pub properties: T
}

#[derive(Deserialize)]
pub struct NotionObject<T> {
    pub results: Vec<T>
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

impl TryFrom<TaskProperties> for Task {
    type Error = anyhow::Error;

    fn try_from(props: TaskProperties) -> Result<Self, Self::Error> {
        Ok(Task {
            id: props.id.rich_text.first().with_context(|| "Task missing id property")?.text.content.to_string(),
            source_id: props.source_id.rich_text.first().with_context(|| "Task missing source id property")?.text.content.to_string(),
            source: TaskSource::from_str(props.source.select.name.as_str())?,
            text: props.text.title.first().with_context(|| "Task missing text property")?.text.content.to_string(),
            status: TaskStatus::from_str(props.status.status.name.as_str())?,
            created_at: props.created_at.created_time,
            updated_at: props.updated_at.last_edited_time,
        })
    }
}
