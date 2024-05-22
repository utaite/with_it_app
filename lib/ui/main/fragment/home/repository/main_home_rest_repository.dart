import 'package:rinf/rinf.dart';
import 'package:with_it/messages/home.pb.dart' as home;
import 'package:with_it/messages/home.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/repository/main_home_repository.dart';

final class MainHomeRestRepository implements MainHomeRepository {
  const MainHomeRestRepository();

  @override
  Future<HomeDeleteResponse> deleteHome(HomeDeleteRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: home.ID,
        operation: RustOperation.Delete,
        message: request.writeToBuffer(),
      ),
    );
    return HomeDeleteResponse.fromBuffer((response?.message).elvis);
  }

  @override
  Future<HomeReadResponse> readHome(HomeReadRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: home.ID,
        operation: RustOperation.Read,
        message: request.writeToBuffer(),
      ),
    );
    return HomeReadResponse.fromBuffer((response?.message).elvis);
  }

  @override
  Future<HomeUpdateResponse> updateHome(HomeUpdateRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: home.ID,
        operation: RustOperation.Update,
        message: request.writeToBuffer(),
      ),
    );
    return HomeUpdateResponse.fromBuffer((response?.message).elvis);
  }
}
