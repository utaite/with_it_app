use crate::api::user::user::{
    UserCreateRequest, UserCreateResponse, UserReadRequest, UserReadResponse,
};
use crate::api::user::user_service::user_service_client::UserServiceClient;
use crate::bridge::{RustOperation, RustRequest, RustResponse};
use crate::module::url;
use prost::Message;
use reqwest::StatusCode;

pub mod result {
    tonic::include_proto!("result");
}

pub mod user {
    tonic::include_proto!("user");
}

pub mod user_service {
    tonic::include_proto!("user_service");
}

pub async fn request(rust_request: RustRequest) -> RustResponse {
    let message_bytes = rust_request.message.unwrap();
    let message = match rust_request.operation {
        RustOperation::Create => match UserServiceClient::connect(url::GRPC).await {
            Ok(mut client) => {
                let request = UserCreateRequest::decode(message_bytes.as_slice()).unwrap();
                let request = tonic::Request::new(request);
                match client.create(request).await {
                    Ok(response) => Some(response.into_inner().encode_to_vec()),
                    Err(e) => {
                        let status = u32::from(StatusCode::INTERNAL_SERVER_ERROR.as_u16());
                        let result = Some(result::Result {
                            status,
                            code: String::new(),
                            r#type: String::new(),
                            messages: vec![e.to_string()],
                        });
                        let response = UserCreateResponse { result };

                        Some(response.encode_to_vec())
                    }
                }
            }
            Err(e) => {
                let status = u32::from(StatusCode::INTERNAL_SERVER_ERROR.as_u16());
                let result = Some(result::Result {
                    status,
                    code: String::new(),
                    r#type: String::new(),
                    messages: vec![e.to_string()],
                });
                let response = UserCreateResponse { result };

                Some(response.encode_to_vec())
            }
        },
        RustOperation::Read => match UserServiceClient::connect(url::GRPC).await {
            Ok(mut client) => {
                let request = UserReadRequest::decode(message_bytes.as_slice()).unwrap();
                let request = tonic::Request::new(request);
                match client.read(request).await {
                    Ok(response) => Some(response.into_inner().encode_to_vec()),
                    Err(e) => {
                        let status = u32::from(StatusCode::INTERNAL_SERVER_ERROR.as_u16());
                        let result = Some(result::Result {
                            status,
                            code: String::new(),
                            r#type: String::new(),
                            messages: vec![e.to_string()],
                        });
                        let response = UserReadResponse { result, data: None };

                        Some(response.encode_to_vec())
                    }
                }
            }
            Err(e) => {
                let status = u32::from(StatusCode::INTERNAL_SERVER_ERROR.as_u16());
                let result = Some(result::Result {
                    status,
                    code: String::new(),
                    r#type: String::new(),
                    messages: vec![e.to_string()],
                });
                let response = UserReadResponse { result, data: None };

                Some(response.encode_to_vec())
            }
        },
        RustOperation::Update => None,
        RustOperation::Delete => None,
    };

    RustResponse {
        message,
        blob: None,
    }
}
