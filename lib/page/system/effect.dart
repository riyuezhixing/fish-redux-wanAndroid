import 'package:azlistview/azlistview.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fishreduxwanandroid/component/tree/state.dart';
import 'package:fishreduxwanandroid/network/wan_repository.dart';
import 'package:fishreduxwanandroid/utils/common.dart';
import 'package:fishreduxwanandroid/utils/utils.dart';

import 'action.dart';
import 'state.dart';

Effect<SystemState> buildEffect() {
  return combineEffects(<Object, Effect<SystemState>>{
    Lifecycle.initState: _init,
    SystemAction.onRefresh: _onRefresh,
  });
}

void _init(Action action, Context<SystemState> ctx) {
  _loadData(ctx);
}

void _loadData(Context<SystemState> ctx) {
  WanRepository.repository.getTreeList().then((list) {
    if (list == null) {
      return;
    }
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = Utils.getPinyin(list[i].name);
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    SuspensionUtil.sortListBySuspensionTag(list);

    List<TreeItemState> itemList = [];
    list.forEach((element) {
      itemList.add(TreeItemState()..treeModel = element);
    });

    ctx.dispatch(SystemActionCreator.updateData(itemList));
    ctx.dispatch(SystemActionCreator.updateStatus(LoadStatus.success));
    ctx.state.controller.finishRefresh();
    ctx.state.controller.resetLoadState();
  }).catchError((e) {
    ctx.dispatch(SystemActionCreator.updateStatus(LoadStatus.fail));
  });
}

void _onRefresh(Action action, Context<SystemState> ctx) {
  _loadData(ctx);
}
