import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxwanandroid/model/home/system_model.dart';

enum SystemAction { updateData, onRefresh, onTabPage, updateStatus }

class SystemActionCreator {
  static Action onRefresh() {
    return const Action(SystemAction.onRefresh);
  }

  static Action updateData(List<TreeModel> list) {
    return Action(SystemAction.updateData, payload: list);
  }

  static Action onTabPage(TreeModel treeModel) {
    return Action(SystemAction.onTabPage, payload: treeModel);
  }

  static Action updateStatus(int status) {
    return Action(SystemAction.updateStatus, payload: status);
  }
}
