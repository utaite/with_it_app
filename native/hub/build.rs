fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::compile_protos("../../messages/user_service.proto").unwrap();
    Ok(())
}
