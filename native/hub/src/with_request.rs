use crate::api;
use crate::bridge::{RustRequestUnique, RustResponse, RustResponseUnique};
use crate::messages;

pub async fn handle_request(request_unique: RustRequestUnique) -> RustResponseUnique {
    let id = request_unique.id;
    let request = request_unique.request;
    let response = match request.resource {
        messages::test::ID => api::test::request(request).await,
        _ => RustResponse::default(),
    };

    RustResponseUnique { id, response }
}
