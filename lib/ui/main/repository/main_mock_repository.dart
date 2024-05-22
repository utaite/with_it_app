import 'package:with_it/messages/result.pb.dart';
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/repository/main_repository.dart';

final class MainMockRepository implements MainRepository {
  const MainMockRepository();

  @override
  Future<UserReadResponse> readUser(UserReadRequest request) async => UserReadResponse(
        result: Result(
          code: Strings.success,
        ),
      );
}
