import 'package:with_it/messages/user.pb.dart';

abstract interface class MainRepository {
  Future<UserCreateResponse> createUser(UserCreateRequest request);

  Future<UserReadResponse> readUser(UserReadRequest request);
}
