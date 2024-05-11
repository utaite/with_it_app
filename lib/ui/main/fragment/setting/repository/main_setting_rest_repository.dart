import 'package:rinf/rinf.dart';
import 'package:with_it/messages/test.pb.dart' as test_proto;
import 'package:with_it/messages/test.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/setting/repository/main_setting_repository.dart';

final class MainSettingRestRepository implements MainSettingRepository {
  const MainSettingRestRepository();

  @override
  Future<TestReadResponse> test(TestReadRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: test_proto.ID,
        operation: RustOperation.Read,
        message: request.writeToBuffer(),
      ),
    );
    return TestReadResponse.fromBuffer((response?.message).elvis);
  }
}
