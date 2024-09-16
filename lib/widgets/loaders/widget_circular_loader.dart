import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_colors.dart';
import '../../base/base_controller.dart';


class WidgetCircularLoader extends StatelessWidget {
  //Data
  final BaseController controller;
  final Widget child;
  final double height;
  final bool isFullscreen;
  final Color loaderColor;

  //constructor
  const WidgetCircularLoader({Key? key, required this.controller, required this.child,
    this.isFullscreen= false, this.height=200, this.loaderColor = kPrimary}) : super(key: key);

  // Build **************************************
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value  ? SizedBox(
        width: Get.width,
        height: isFullscreen?double.infinity:height,
        child: Center(
            child:
            SpinKitWaveSpinner(
                color: loaderColor,
                size: 32,

            )
        )
    ) : child);
  }
}