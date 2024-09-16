

import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/args/tab_args.dart';


class TwoTabsController extends BaseController{
  @override
  BaseRepository? get repository => null;

  /// Data **************************************************
  List<TabArgs> tabs = [];
  int selectedId = 0;


  /// logic *************************************************
  init(List<TabArgs> tabs,{int? init}) {
    this.tabs = tabs;
    selectedId = init?? tabs.first.tabId;
  }

  onSelectedTab(TabArgs args){
    selectedId =  args.tabId;
    update();
  }
}