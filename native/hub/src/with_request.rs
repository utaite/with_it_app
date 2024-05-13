use crate::bridge::{RustRequestUnique, RustResponse, RustResponseUnique};
use crate::{api, messages};

pub async fn handle_request(request_unique: RustRequestUnique) -> RustResponseUnique {
    let id = request_unique.id;
    let request = request_unique.request;
    let response: Option<RustResponse> = match request.resource {
        messages::test::ID => Some(api::test::request(request).await),
        messages::user::ID => Some(api::user::request(request).await),
        _ => None,
    };

    RustResponseUnique { id, response }
}
