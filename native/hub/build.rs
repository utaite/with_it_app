fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::compile_protos("../../messages/home_service.proto").unwrap();
    tonic_build::compile_protos("../../messages/planner_service.proto").unwrap();
    tonic_build::compile_protos("../../messages/user_service.proto").unwrap();
    Ok(())
}
