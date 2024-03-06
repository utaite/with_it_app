use crate::bridge::{RustOperation, RustRequest, RustResponse};
use crate::messages::test::{TestRequest, TestResponse};
use prost::Message;

pub async fn request(rust_request: RustRequest) -> RustResponse {
    let message_bytes = rust_request.message.unwrap();
    let message = match rust_request.operation {
        RustOperation::Create => None,
        RustOperation::Read => {
            let request = TestRequest::decode(message_bytes.as_slice()).unwrap();
            Some(
                TestResponse {
                    output: request.input * 2,
                }
                .encode_to_vec(),
            )
        }
        RustOperation::Update => None,
        RustOperation::Delete => None,
    };

    RustResponse {
        successful: true,
        message,
        blob: None,
    }
}
