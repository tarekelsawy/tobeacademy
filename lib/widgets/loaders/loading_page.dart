import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../base/base_controller.dart';
import '../../theme/app_colors.dart';

class LoadingPage extends StatelessWidget {
  final BaseController controller;
  final Widget child;
  final Color loaderColor;
  const LoadingPage({Key? key,required this.controller,required this.child, this.loaderColor = kPrimary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Stack(
        children: [
          child,
          if(controller.loading.value)
          Container(
            height: Get.height,
            width: Get.width,
            color: kGreyLight.withOpacity(0.5),
          ),
          if(controller.loading.value)
             Align(
              alignment: Alignment.center,
              child: SpinKitHourGlass(color: loaderColor,size: 35,)),
        ],
      ),
    );
  }
}
