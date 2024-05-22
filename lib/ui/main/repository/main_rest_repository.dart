import 'package:rinf/rinf.dart';
import 'package:with_it/messages/user.pb.dart' as user;
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/repository/main_repository.dart';

final class MainRestRepository implements MainRepository {
  const MainRestRepository();

  @override
  Future<UserReadResponse> readUser(UserReadRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: user.ID,
        operation: RustOperation.Read,
        message: request.writeToBuffer(),
      ),
    );
    return UserReadResponse.fromBuffer((response?.message).elvis);
  }
}
