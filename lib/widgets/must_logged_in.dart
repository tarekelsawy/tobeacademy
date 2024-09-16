import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_lottie.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:lottie/lottie.dart';

class MustLoggedIn extends StatelessWidget {
  const MustLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppLottie.cancelOrder,
            height: 150, width: 150),
        Text(
          'يجب عليك تسجيل الدخول',
          textAlign: TextAlign.center,
          style: Get.textTheme.displayMedium!.copyWith(height: 1.6, fontSize: 16),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        BaseTextButton(
          title: 'سجل الان',

          width: Get.width,
          radius: 8,
          fontSize: 18,
          onPress: () => Get.toNamed(Routes.auth),
        )
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}
