import 'package:to_do_list_pro_project/data/data_source/goal_list_data.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';

class GoalListRepo {
  GoalListData goalListData;

  GoalListRepo(this.goalListData);

  List<GoalModel> getGoals() {
    return goalListData.goals;
  }

  void addGoal(GoalModel goal) {
    goalListData.addGoal(goal);
  }

  void removeGoal(GoalModel goal) {
    goalListData.removeGoal(goal);
  }
}