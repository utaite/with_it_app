import 'package:with_it/messages/test.pb.dart';
import 'package:with_it/ui/main/fragment/setting/repository/main_setting_repository.dart';

final class MainSettingMockRepository implements MainSettingRepository {
  const MainSettingMockRepository();

  @override
  Future<TestReadResponse> test(TestReadRequest request) async => TestReadResponse(
        output: request.input,
      );
}
