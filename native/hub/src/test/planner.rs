use crate::api::planner::planner::{
    PlannerReadRequest, PlannerReadRequestData, PlannerReadResponse,
};
use crate::bridge::{RustOperation, RustRequest, RustRequestUnique};
use crate::{messages, with_request};
use prost::Message;
use tokio_with_wasm::tokio;

#[tokio::test]
async fn planner_read_test() {
    let request = PlannerReadRequest {
        data: Some(PlannerReadRequestData {
            device_token: "fOf8USUMNknhrw-gZ_6rfc:APA91bFbZgZ_h_HxilY-l7R_NigUDZnJz3cmC8P2dgxMeJgPdU-VC8oP7-9wo9km337hjaTm4EkvTzxB0eS2aBJ8xW-AC43SXQtB6iLdqre43Dxg8ttnTwX7WXPZN8kBj-S4H0jcMhGB".to_string(),
            date_time: "2024-05-22".to_string(),
        }),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::planner::ID,
        operation: RustOperation::Read,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = PlannerReadResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
}
