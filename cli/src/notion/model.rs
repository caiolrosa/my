use std::str::FromStr;

use anyhow::{Context, Result};
use serde::{Serialize, Deserialize};
use strum_macros::{EnumString, Display};
use uuid::Uuid;

#[derive(Serialize, Deserialize)]
pub struct Text {
    pub content: String
}

#[derive(Serialize, Deserialize)]
pub struct RichText {
    pub text: Text
}

#[derive(Serialize, Deserialize)]
pub struct RichTextProperty {
    pub rich_text: Vec<RichText>
}

#[derive(Serialize, Deserialize)]
pub struct Select {
    pub name: String
}

#[derive(Serialize, Deserialize)]
pub struct SelectProperty {
    pub select: Select
}

#[derive(Serialize, Deserialize)]
pub struct Title {
    pub text: Text
}

#[derive(Serialize, Deserialize)]
pub struct TitleProperty {
    pub title: Vec<Title>
}

#[derive(Serialize, Deserialize)]
pub struct Status {
    pub name: String
}

#[derive(Serialize, Deserialize)]
pub struct StatusProperty {
    pub status: Status
}

#[derive(Serialize, Deserialize)]
pub struct CreatedAtProperty {
    pub created_time: String
}

#[derive(Serialize, Deserialize)]
pub struct UpdatedAtProperty {
    pub last_edited_time: String
}

#[derive(Serialize, Deserialize)]
pub struct TaskProperties {
    pub id: RichTextProperty,
    pub source_id: RichTextProperty,
    pub source: SelectProperty,
    pub text: TitleProperty,
    pub status: StatusProperty,
    pub created_at: CreatedAtProperty,
    pub updated_at: UpdatedAtProperty
}

#[derive(Serialize, Deserialize)]
pub struct CreateTaskProperties {
    pub id: RichTextProperty,
    pub source_id: RichTextProperty,
    pub source: SelectProperty,
    pub text: TitleProperty,
    pub status: StatusProperty,
}

#[derive(Serialize, Deserialize)]
pub struct Parent {
    pub database_id: String
}

#[derive(Serialize, Deserialize)]
pub struct Page<T> {
    pub parent: Parent,
    pub properties: T
}

#[derive(Serialize, Deserialize)]
pub struct NotionObject<T> {
    pub results: Vec<T>
}

#[derive(Debug, Deserialize, EnumString, Display)]
pub enum TaskSource {
    #[strum(serialize = "cli")]
    Cli,

    #[strum(serialize = "jira")]
    Jira,
}

#[derive(Debug, Deserialize, EnumString, Display)]
pub enum TaskStatus {
    #[strum(serialize = "not_started")]
    NotStarted,

    #[strum(serialize = "in_progress")]
    InProgress,

    #[strum(serialize = "done")]
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

pub struct CreateTask {
    pub source_id: String,
    pub source: TaskSource,
    pub text: String,
    pub status: TaskStatus,
}

impl CreateTask {
    pub fn new(source_id: String, source: TaskSource, text: String, status: TaskStatus) -> CreateTask {
        CreateTask { source_id, source, text, status }
    }
}

impl CreateTaskProperties {
    pub fn new(create_task: CreateTask) -> CreateTaskProperties {
        let task_id = Uuid::new_v4();
        CreateTaskProperties {
            id: RichTextProperty { rich_text: vec![RichText { text: Text { content: task_id.to_string() } }] },
            source_id: RichTextProperty { rich_text: vec![RichText { text: Text { content: create_task.source_id } }] },
            source: SelectProperty { select: Select { name: create_task.source.to_string() } },
            text: TitleProperty { title: vec![Title { text: Text { content: create_task.text } }] },
            status: StatusProperty { status: Status { name: create_task.status.to_string() } },
        }
    }
}

impl<T> Page<T> {
    pub fn new(database_id: String, properties: T) -> Page<T> {
        Page {
            properties,
            parent: Parent { database_id }
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
