use crate::api::planner::planner::{PlannerReadRequest, PlannerReadResponse};
use crate::api::planner::planner_service::planner_service_client::PlannerServiceClient;
use crate::bridge::{RustOperation, RustRequest, RustResponse};
use crate::module::url;
use prost::Message;
use reqwest::StatusCode;

pub mod result {
    tonic::include_proto!("result");
}

pub mod planner {
    tonic::include_proto!("planner");
}

pub mod planner_service {
    tonic::include_proto!("planner_service");
}

pub async fn request(rust_request: RustRequest) -> RustResponse {
    let message_bytes = rust_request.message.unwrap();
    let message = match rust_request.operation {
        RustOperation::Create => None,
        RustOperation::Read => match PlannerServiceClient::connect(url::GRPC).await {
            Ok(mut client) => {
                let request = PlannerReadRequest::decode(message_bytes.as_slice()).unwrap();
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
                        let response = PlannerReadResponse { result, data: None };

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
                let response = PlannerReadResponse { result, data: None };

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
