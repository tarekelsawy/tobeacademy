import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';


abstract class BottomBarController<R extends BaseRepository>
    extends BaseController<R> with GetSingleTickerProviderStateMixin{
  /// Data *********************************************************************
  var items = [
    TabItem(
        icon: Icons.chat,
        title: 'chat'.tr,),
    TabItem(
        icon: Icons.home_outlined,
        title: 'home'.tr,
      ),
    TabItem(
        icon: Icons.live_tv_rounded,
        title:  'live'.tr,
       ),
    const TabItem(
      icon: Icons.file_open_sharp,
      title: 'التقرير',
    )
  ].obs;
  TabController? tabController;
  var selectedIndex = Get.arguments ?? 1.obs; // initial home tab page

  /// Listeners ****************************************************************
  selectIndex(int index) async {
    Get.until((route) => route.isFirst);
    selectedIndex.value = index;
    tabController!.index = index;
  }

  @override
  onCreate() {
    tabController = TabController(length: items.length, vsync: this);
    tabController!.index = 1;
  }
}
