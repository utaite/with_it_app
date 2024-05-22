import 'package:with_it/messages/home.pb.dart';
import 'package:with_it/messages/result.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/repository/main_home_repository.dart';

final class MainHomeMockRepository implements MainHomeRepository {
  const MainHomeMockRepository();

  @override
  Future<HomeDeleteResponse> deleteHome(HomeDeleteRequest request) async => HomeDeleteResponse(
        result: Result(
          code: Strings.success,
        ),
      );

  @override
  Future<HomeReadResponse> readHome(HomeReadRequest request) async => HomeReadResponse(
        result: Result(
          code: Strings.success,
        ),
      );

  @override
  Future<HomeUpdateResponse> updateHome(HomeUpdateRequest request) async => HomeUpdateResponse(
        result: Result(
          code: Strings.success,
        ),
      );
}
