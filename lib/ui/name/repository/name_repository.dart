import 'package:with_it/messages/user.pb.dart';

abstract interface class NameRepository {
  Future<UserCreateResponse> createUser(UserCreateRequest request);
}
