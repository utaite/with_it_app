import 'package:rinf/rinf.dart';
import 'package:with_it/messages/planner.pb.dart' as planner;
import 'package:with_it/messages/planner.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/planner/repository/main_planner_repository.dart';

final class MainPlannerRestRepository implements MainPlannerRepository {
  const MainPlannerRestRepository();

  @override
  Future<PlannerReadResponse> readPlanner(PlannerReadRequest request) async {
    final response = await requestToRust(
      RustRequest(
        resource: planner.ID,
        operation: RustOperation.Read,
        message: request.writeToBuffer(),
      ),
    );
    return PlannerReadResponse.fromBuffer((response?.message).elvis);
  }
}
