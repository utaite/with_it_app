import 'package:rinf/rinf.dart';
import 'package:with_it/messages/user.pb.dart' as user;
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/messages/user.pbserver.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/name/repository/name_repository.dart';

final class NameRestRepository implements NameRepository {
  const NameRestRepository();

  @override
  Future<UserCreateResponse> createUser(UserCreateRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: user.ID,
        operation: RustOperation.Create,
        message: request.writeToBuffer(),
      ),
    );
    return UserCreateResponse.fromBuffer((response?.message).elvis);
  }
}
