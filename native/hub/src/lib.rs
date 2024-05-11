use bridge::respond_to_dart;
use tokio_with_wasm::tokio;
use with_request::handle_request;

mod api;
mod bridge;
mod messages;
mod model;
mod test;
mod with_request;

async fn main() {
    let mut request_receiver = bridge::get_request_receiver();
    while let Some(request_unique) = request_receiver.recv().await {
        tokio::spawn(async {
            let response_unique = handle_request(request_unique).await;
            respond_to_dart(response_unique);
        });
    }
}
