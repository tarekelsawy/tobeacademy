import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:upgrader/upgrader.dart';
import '../../base/base_view.dart';
import '../../models/api/page_attributes.dart';
import '../../theme/app_images.dart';
import 'splash_controller.dart';

class SplashScreen extends BaseView<SplashController> {
  SplashScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(showAppBar: false,);

  @override
  Widget buildBody(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(canDismissDialog: false,showIgnore: false, showLater: false, showReleaseNotes: false),
      child: Obx(
            () => AnimatedOpacity(
          opacity: controller.logoOpacity.value,
          duration: const Duration(seconds: 3),
          curve: Curves.linear,
          child: Center(
            child: Image.asset(
               pref.darkTheme? AppImages.logoBlack: AppImages.logoWhite,
              width: Get.width - 100,
            ),
          ),
        ),
      ),
    );
  }
}
