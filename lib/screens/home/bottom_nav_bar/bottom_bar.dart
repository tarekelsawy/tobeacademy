import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_theme_controllrt.dart';
import 'package:icourseapp/screens/home/bottom_nav_bar/bottom_bar_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';


class BottomBar extends StatelessWidget {
  /// Data *******************************************************
  final BottomBarController controller;

  const BottomBar({Key? key, required this.controller}) : super(key: key);

  /// Build ******************************************************
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseThemeController>(
      init: Get.find<BaseThemeController>(),
      builder: (_) {
        return IntrinsicHeight(
          child: Obx(
            ()=> SafeArea(
              child: ConvexAppBar(
                controller: controller.tabController,
                initialActiveIndex: 1,
                style: TabStyle.flip,
                color: _.isDarkTheme? kWhite : kGrayE3,
                activeColor: kPrimary,
                height: 70,
                backgroundColor: _.isDarkTheme? kPrimary18 : kWhite,
                items: controller.items.toList(),
                onTap: controller.selectIndex,
              ),
            ),
          ),
        ).paddingOnly(top: 15);
      }
    );
  }
}
