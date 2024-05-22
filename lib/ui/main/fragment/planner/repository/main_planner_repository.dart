import 'package:with_it/messages/planner.pb.dart';

abstract interface class MainPlannerRepository {
  Future<PlannerReadResponse> readPlanner(PlannerReadRequest request);
}
