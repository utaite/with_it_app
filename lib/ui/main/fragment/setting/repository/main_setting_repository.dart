import 'package:with_it/messages/test.pb.dart';

abstract interface class MainSettingRepository {
  Future<TestReadResponse> test(TestReadRequest request);
}
