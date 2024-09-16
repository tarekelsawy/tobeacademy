import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/screens/user_guide/user_guide_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/api/page_attributes.dart';
import 'package:icourseapp/theme/app_colors.dart';

import '../../widgets/buttons/base_text_button.dart';

class UserGuideScreen extends BaseView<UserGuideController> {
  UserGuideScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(showAppBar: false);

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: controller.onPageChange,
                controller: controller.pageController,
                children: controller.userGuides
                    .map<Widget>((e) => Column(
                      children: [
                        Image.asset(e.image, height: 300,).paddingOnly(bottom: 10),
                        Text(e.description, style: Get.textTheme.displayMedium!.copyWith(fontSize: 16,fontWeight: FontWeight.w800),),
                      ],
                    ))
                    .toList(),
              ).paddingOnly(bottom: 10),
            ),
            SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 4,
                    effect:  const ExpandingDotsEffect(
                        activeDotColor: kPrimary,
                        dotColor: kGrayD5,
                        dotWidth: 10,
                        dotHeight: 6,
                        spacing: 0))
                .paddingOnly(bottom: 24),
            const Spacer(),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Obx(
                ()=> BaseTextButton(
                  title: controller.currentPosition.value == 3? 'هيا بنا لنبدأ': 'التالي',
                  width: controller.currentPosition.value == 3? 150: 115,
                  iconData: Icons.arrow_forward_ios,
                  showArrow: controller.currentPosition.value == 3? false: true,
                  onPress: controller.onNavigateToLogin,
                  radius: 10,
                ),
              ),
            ),
            // BaseTextButton(
            //   title: 'login'.tr,
            //   onPress: controller.onNavigateToLogin,
            //   radius: 10,
            // ).paddingOnly(bottom: 12),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 24),
      ),
    );
  }
}
