use crate::bridge::{RustOperation, RustRequest, RustRequestUnique};
use crate::messages::test::{TestReadRequest, TestReadResponse};
use crate::{messages, with_request};
use prost::Message;
use tokio_with_wasm::tokio;

#[tokio::test]
async fn test_read_test() {
    let request = TestReadRequest {
        input: "World".to_string(),
    };
    println!("request: {:#?}", request);

    let request = RustRequest {
        resource: messages::test::ID,
        operation: RustOperation::Read,
        message: Some(request.encode_to_vec()),
        blob: None,
    };
    let rust_request_unique = RustRequestUnique { id: 0, request };
    let response_unique = with_request::handle_request(rust_request_unique).await;
    let message_bytes = response_unique.response.unwrap().message.unwrap();
    let response = TestReadResponse::decode(message_bytes.as_slice()).unwrap();
    println!("response: {:#?}", response);
    assert_eq!(response.output, "Hello, World!");
}
