use crate::bridge::{RustOperation, RustRequest, RustResponse};
use crate::messages::test::{TestReadRequest, TestReadResponse};
use prost::Message;

pub async fn request(rust_request: RustRequest) -> RustResponse {
    let message_bytes = rust_request.message.unwrap();
    let message = match rust_request.operation {
        RustOperation::Create => None,
        RustOperation::Read => {
            let request = TestReadRequest::decode(message_bytes.as_slice()).unwrap();
            let output = format!("Hello, {}!", request.input);

            Some(TestReadResponse { output }.encode_to_vec())
        }
        RustOperation::Update => None,
        RustOperation::Delete => None,
    };

    RustResponse {
        message,
        blob: None,
    }
}
