use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct StatusModel<T> {
    pub code: String,
    pub r#type: String,
    pub message_list: Vec<String>,
    pub data: Option<T>,
}
