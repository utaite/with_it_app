import 'package:with_it/messages/result.pb.dart';
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/name/repository/name_repository.dart';

final class NameMockRepository implements NameRepository {
  const NameMockRepository();

  @override
  Future<UserCreateResponse> createUser(UserCreateRequest request) async => UserCreateResponse(
        result: Result(
          code: Strings.success,
        ),
      );
}
