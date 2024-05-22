import 'package:with_it/messages/user.pb.dart';

abstract interface class MainRepository {
  Future<UserReadResponse> readUser(UserReadRequest request);
}
