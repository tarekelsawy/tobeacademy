import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/auth/login/auth_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:icourseapp/utils/validation.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';

class AuthScreen extends BaseView<AuthController> {
  AuthScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(
      resizeToAvoidBottomInset: true,
      title: 'تسجيل الدخول',
      showLine: false,
      showNav: false);

  @override
  String? get tag => null;

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset(
                  !pref.darkTheme ? AppImages.logoBlack : AppImages.logoWhite,
                  height: 150,
                ).paddingOnly(bottom: 40),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'email'.tr,
                      style: Get.textTheme.displayMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    )).paddingOnly(bottom: 5).paddingSymmetric(horizontal: 5),
                Container(
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      border: Border.all(color: kGreyE2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BaseTextField(
                      validator: ValidationUtil.validateEmail,
                      hintTxt: 'example@example.com',
                      controller: controller.email,
                      textInputType: TextInputType.emailAddress,
                    )).paddingOnly(bottom: 20),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'password'.tr,
                      style: Get.textTheme.displayMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    )).paddingOnly(bottom: 5).paddingSymmetric(horizontal: 5),
                Container(
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      border: Border.all(color: kGreyE2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BaseTextField(
                      hintTxt: '',
                      validator: (value) =>
                          ValidationUtil.validatePassword(value),
                      password: false,
                      obscureText: true,
                      controller: controller.password,
                    )).paddingOnly(bottom: 10),
                Row(
                  children: [
                    Text(
                      'هل نسيت كلمه المرور؟',
                      style:
                          Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                    ),
                    InkWell(
                        onTap: () => Get.toNamed(Routes.email),
                        child: Text(
                          'اعاده تعيين',
                          style: Get.textTheme.displayMedium!
                              .copyWith(fontSize: 16, color: kPrimary),
                        )),
                  ],
                ).paddingOnly(bottom: 10),

                Row(
                  children: [
                    Text(
                      'ليس لديك حساب؟',
                      style:
                          Get.textTheme.displayMedium!.copyWith(fontSize: 16),
                    ),
                    InkWell(
                        onTap: () => Get.toNamed(Routes.register),
                        child: Text(
                          'إنشاء حساب',
                          style: Get.textTheme.displayMedium!
                              .copyWith(fontSize: 16, color: kPrimary),
                        )),
                  ],
                ).paddingOnly(bottom: 30),
                RoundedLoadingButton(
                  title: 'login'.tr,
                  controller: controller.btnController,
                  height: 40,
                  borderRadius: 6,
                  fontSize: 16,
                  fontFamily: kMedium,
                  width: Get.width,
                  onPressed: controller.onLogin,
                ).paddingOnly(bottom: 10),
                // todo for ios review
                // const SizedBox(height: 20),
                // RoundedLoadingButton(
                //   title: 'Enter As Guest',
                //   controller: controller.btnController,
                //   height: 40,
                //   borderRadius: 6,
                //   fontSize: 16,
                //   fontFamily: kMedium,
                //   width: Get.width,
                //   onPressed: () {
                //     Get.toNamed(Routes.home);
                //   },
                // ).paddingOnly(bottom: 10),
                //!----------------------
                /* Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: kGrey57,
                    )),
                    Text(
                      'أو تسجيل الدخول بواسطه',
                      style: Get.textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ).paddingSymmetric(horizontal: 10),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: kGrey57,
                    )),
                  ],
                ).paddingOnly(top: 10, bottom: 15),
                if (Platform.isIOS)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialContainer(
                          imageName: AppImages.google,
                          title: 'جوجل',
                          kPress: controller.onGoogleAuth),
                      const SizedBox(width: 12),
                      socialContainer(
                          isApple: true,
                          imageName: AppImages.apple,
                          title: 'أبل',
                          kPress: controller.onAppleAuth),
                    ],
                  ).paddingOnly(bottom: 20),
                if (Platform.isAndroid)
                  BaseTextButton(
                    title: 'جوجل',
                    onPress: controller.onGoogleAuth,
                    backgroundColor: kWhite,
                    borderColor: Colors.transparent,
                    svgImage: AppImages.google,
                    fontFamily: kBold,
                    radius: 5,
                    txtColor: kBlack,
                    showSpacer: true,
                  ).paddingOnly(bottom: 20),*/
                //! ------------------------------------
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
//!------------------------------------
/*Widget socialContainer(
    {required String imageName,
    required String title,
    bool isApple = false,
    VoidCallback? kPress}) {
  return InkWell(
    onTap: kPress,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isApple && !pref.darkTheme ? kBlack : null,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: pref.darkTheme ? kWhite : kBlack)),
          child: SvgPicture.asset(
            imageName,
            width: 20,
            height: 20,
          ),
        ),
        Text(title, style: Get.textTheme.displayMedium?.copyWith(fontSize: 15)),
      ],
    ),
  );
}*/
//!------------------------------------