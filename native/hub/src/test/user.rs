use crate::api::user::user::{UserCreateRequest, UserCreateRequestData, UserCreateResponse, UserReadRequest, UserReadRequestData, UserReadResponse};
use crate::bridge::{RustOperation, RustRequest, RustRequestUnique};
use crate::{messages, with_request};
use prost::Message;
use tokio_with_wasm::tokio;

#[tokio::test]
async fn user_create_test() {
    let request = UserCreateRequest {
        data: Some(UserCreateRequestData {
            name: "yuyu6888".to_string(),
            device_token: "rust".to_string(),
        }),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::user::ID,
        operation: RustOperation::Create,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = UserCreateResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
}

#[tokio::test]
async fn user_read_test() {
    let request = UserReadRequest {
        data: Some(UserReadRequestData {
            device_token: "rust".to_string(),
        }),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::user::ID,
        operation: RustOperation::Read,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = UserReadResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
}
