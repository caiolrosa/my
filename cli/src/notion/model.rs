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
    pub status: StatusProperty
}

#[derive(Serialize, Deserialize)]
pub struct UpdateTaskProperties {
    pub source: SelectProperty,
    pub text: TitleProperty,
    pub status: StatusProperty
}

#[derive(Serialize, Deserialize)]
pub struct Parent {
    pub database_id: String
}

#[derive(Serialize, Deserialize)]
pub struct Page<T> {
    pub id: String,
    pub parent: Parent,
    pub properties: T
}

#[derive(Serialize, Deserialize)]
pub struct CreatePage<T> {
    pub parent: Parent,
    pub properties: T,
}

#[derive(Serialize, Deserialize)]
pub struct UpdatePage<T> {
    pub archived: bool,
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
    page_id: String,

    pub id: String,
    pub source_id: String,
    pub source: TaskSource,
    pub text: String,
    pub status: TaskStatus,
    pub created_at: String,
    pub updated_at: String,
}

pub struct CreateTaskPayload {
    pub source_id: String,
    pub source: TaskSource,
    pub text: String,
    pub status: TaskStatus,
}

pub struct UpdateTaskPayload {
    pub source: TaskSource,
    pub text: String,
    pub status: TaskStatus,
}

#[derive(Serialize)]
pub struct ArchiveTaskPayload {
    pub archived: bool
}

impl Task {
    pub fn complete(&mut self) {
        self.status = TaskStatus::Done
    }

    pub fn notion_page_id(&self) -> &str {
        &self.page_id
    }
}

impl ArchiveTaskPayload {
    pub fn new(archived: bool) -> ArchiveTaskPayload {
        ArchiveTaskPayload { archived }
    }
}

impl From<Task> for UpdateTaskPayload {
    fn from(t: Task) -> UpdateTaskPayload {
        UpdateTaskPayload { source: t.source, text: t.text, status: t.status }
    }
}

impl From<CreateTaskPayload> for CreateTaskProperties {
    fn from(ct: CreateTaskPayload) -> CreateTaskProperties {
        let task_id = Uuid::new_v4();

        CreateTaskProperties {
            id: RichTextProperty { rich_text: vec![RichText { text: Text { content: task_id.to_string() } }] },
            source_id: RichTextProperty { rich_text: vec![RichText { text: Text { content: ct.source_id } }] },
            source: SelectProperty { select: Select { name: ct.source.to_string() } },
            text: TitleProperty { title: vec![Title { text: Text { content: ct.text } }] },
            status: StatusProperty { status: Status { name: ct.status.to_string() } },
        }
    }
}

impl From<UpdateTaskPayload> for UpdateTaskProperties {
    fn from(ut: UpdateTaskPayload) -> UpdateTaskProperties {
        UpdateTaskProperties {
            source: SelectProperty { select: Select { name: ut.source.to_string() } },
            text: TitleProperty { title: vec![Title { text: Text { content: ut.text } }] },
            status: StatusProperty { status: Status { name: ut.status.to_string() } },
        }
    }
}

impl<T> CreatePage<T> {
    pub fn new(database_id: String, properties: T) -> CreatePage<T> {
        CreatePage {
            properties,
            parent: Parent { database_id }
        }
    }
}

impl<T> UpdatePage<T> {
    pub fn new(archived: bool, properties: T) -> UpdatePage<T> {
        UpdatePage { archived, properties }
    }
}

impl TryFrom<Page<TaskProperties>> for Task {
    type Error = anyhow::Error;

    fn try_from(page: Page<TaskProperties>) -> Result<Self, Self::Error> {
        Ok(Task {
            page_id: page.id,
            id: page.properties.id.rich_text.first().with_context(|| "Task missing id property")?.text.content.to_string(),
            source_id: page.properties.source_id.rich_text.first().with_context(|| "Task missing source id property")?.text.content.to_string(),
            source: TaskSource::from_str(page.properties.source.select.name.as_str())?,
            text: page.properties.text.title.first().with_context(|| "Task missing text property")?.text.content.to_string(),
            status: TaskStatus::from_str(page.properties.status.status.name.as_str())?,
            created_at: page.properties.created_at.created_time,
            updated_at: page.properties.updated_at.last_edited_time,
        })
    }
}
