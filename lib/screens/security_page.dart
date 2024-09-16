import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';

class SecurityPage extends BaseView {
  final String? message;
   SecurityPage({Key? key, this.message}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(showAppBar: false,showNav: false);

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo).paddingOnly(bottom: 10),
          Text('لا يمكنك إستخدام التطبيق!', style: Get.textTheme.displayMedium!.copyWith(fontSize: 20,color: kPrimary),).paddingOnly(bottom: 10),
          Text(message?? 'ربما تستخدم وضع المطور من الاعدادات او انك تستخدم محاكي', style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),textAlign: TextAlign.center,),

        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
