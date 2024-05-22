import 'package:with_it/messages/home.pb.dart';

abstract interface class MainHomeRepository {
  Future<HomeDeleteResponse> deleteHome(HomeDeleteRequest request);

  Future<HomeReadResponse> readHome(HomeReadRequest request);

  Future<HomeUpdateResponse> updateHome(HomeUpdateRequest request);
}
