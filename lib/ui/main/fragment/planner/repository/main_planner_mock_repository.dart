import 'package:with_it/messages/planner.pb.dart';
import 'package:with_it/messages/result.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/planner/repository/main_planner_repository.dart';

final class MainPlannerMockRepository implements MainPlannerRepository {
  const MainPlannerMockRepository();

  @override
  Future<PlannerReadResponse> readPlanner(PlannerReadRequest request) async => PlannerReadResponse(
        result: Result(
          code: Strings.success,
        ),
      );
}
