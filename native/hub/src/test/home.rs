use crate::api::home::home::{
    HomeDeleteRequest, HomeDeleteRequestData, HomeDeleteResponse, HomeReadRequest,
    HomeReadRequestData, HomeReadResponse, HomeUpdateRequest, HomeUpdateRequestData,
    HomeUpdateResponse,
};
use crate::bridge::{RustOperation, RustRequest, RustRequestUnique};
use crate::{messages, with_request};
use prost::Message;
use tokio_with_wasm::tokio;

#[tokio::test]
async fn home_read_test() {
    let request = HomeReadRequest {
        data: Some(HomeReadRequestData {
            device_token: "fOf8USUMNknhrw-gZ_6rfc:APA91bFbZgZ_h_HxilY-l7R_NigUDZnJz3cmC8P2dgxMeJgPdU-VC8oP7-9wo9km337hjaTm4EkvTzxB0eS2aBJ8xW-AC43SXQtB6iLdqre43Dxg8ttnTwX7WXPZN8kBj-S4H0jcMhGB".to_string(),
            date_time: "2024-05-22".to_string(),
        }),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::home::ID,
        operation: RustOperation::Read,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = HomeReadResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
}

#[tokio::test]
async fn home_update_test() {
    let request = HomeUpdateRequest {
        data: Some(HomeUpdateRequestData {
            plan_id: 16,
            subject_id: 2,
        }),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::home::ID,
        operation: RustOperation::Update,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = HomeUpdateResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
}

#[tokio::test]
async fn home_delete_test() {
    let request = HomeDeleteRequest {
        data: Some(HomeDeleteRequestData { plan_id: 17 }),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::home::ID,
        operation: RustOperation::Delete,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = HomeDeleteResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
}
