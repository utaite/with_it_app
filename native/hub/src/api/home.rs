use crate::api::home::home::{
    HomeDeleteRequest, HomeDeleteResponse, HomeReadRequest, HomeReadResponse, HomeUpdateRequest,
    HomeUpdateResponse,
};
use crate::api::home::home_service::home_service_client::HomeServiceClient;
use crate::bridge::{RustOperation, RustRequest, RustResponse};
use crate::module::url;
use prost::Message;
use reqwest::StatusCode;

pub mod result {
    tonic::include_proto!("result");
}

pub mod home {
    tonic::include_proto!("home");
}

pub mod home_service {
    tonic::include_proto!("home_service");
}

pub async fn request(rust_request: RustRequest) -> RustResponse {
    let message_bytes = rust_request.message.unwrap();
    let message = match rust_request.operation {
        RustOperation::Create => None,
        RustOperation::Read => match HomeServiceClient::connect(url::GRPC).await {
            Ok(mut client) => {
                let request = HomeReadRequest::decode(message_bytes.as_slice()).unwrap();
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
                        let response = HomeReadResponse { result, data: None };

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
                let response = HomeReadResponse { result, data: None };

                Some(response.encode_to_vec())
            }
        },
        RustOperation::Update => match HomeServiceClient::connect(url::GRPC).await {
            Ok(mut client) => {
                let request = HomeUpdateRequest::decode(message_bytes.as_slice()).unwrap();
                let request = tonic::Request::new(request);
                match client.update(request).await {
                    Ok(response) => Some(response.into_inner().encode_to_vec()),
                    Err(e) => {
                        let status = u32::from(StatusCode::INTERNAL_SERVER_ERROR.as_u16());
                        let result = Some(result::Result {
                            status,
                            code: String::new(),
                            r#type: String::new(),
                            messages: vec![e.to_string()],
                        });
                        let response = HomeUpdateResponse { result };

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
                let response = HomeUpdateResponse { result };

                Some(response.encode_to_vec())
            }
        },
        RustOperation::Delete => match HomeServiceClient::connect(url::GRPC).await {
            Ok(mut client) => {
                let request = HomeDeleteRequest::decode(message_bytes.as_slice()).unwrap();
                let request = tonic::Request::new(request);
                match client.delete(request).await {
                    Ok(response) => Some(response.into_inner().encode_to_vec()),
                    Err(e) => {
                        let status = u32::from(StatusCode::INTERNAL_SERVER_ERROR.as_u16());
                        let result = Some(result::Result {
                            status,
                            code: String::new(),
                            r#type: String::new(),
                            messages: vec![e.to_string()],
                        });
                        let response = HomeDeleteResponse { result };

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
                let response = HomeDeleteResponse { result };

                Some(response.encode_to_vec())
            }
        },
    };

    RustResponse {
        message,
        blob: None,
    }
}
