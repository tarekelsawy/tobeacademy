import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/forgeot_password/reset_password/reset_password_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:icourseapp/utils/validation.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';
import '../../../main.dart';



class ResetPasswordScreen extends BaseView<ResetPasswordController> {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: 'اعاده تعيين كلمه المرور' ,  showLine: false, resizeToAvoidBottomInset: true, showNav: false);

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
                  height: 200,
                ).paddingOnly(bottom: 20),

                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'password'.tr,
                      style: Get.textTheme.displayMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ))
                    .paddingOnly(bottom: 5)
                    .paddingSymmetric(horizontal: 5),

                Container(
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      border: Border.all(color: kGreyE2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BaseTextField(
                      hintTxt: '',
                      validator:(value)=> ValidationUtil.validatePassword(value),
                      password: false,
                      obscureText: true,
                      controller: controller.password,
                    )).paddingOnly(bottom: 20),

                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'تأكيد كلمه المرور',
                      style: Get.textTheme.displayMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ))
                    .paddingOnly(bottom: 5)
                    .paddingSymmetric(horizontal: 5),

                Container(
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      border: Border.all(color: kGreyE2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BaseTextField(
                      hintTxt: '',
                      validator:(value)=> ValidationUtil.validateConfirmPassword(value,controller.password.text),
                      password: false,
                      obscureText: true,
                      controller: controller.confirmPassword,
                    )).paddingOnly(bottom: 20),


                RoundedLoadingButton(
                  title: 'تأكيد',
                  controller: controller.btnController,
                  height: 50,
                  borderRadius: 15,
                  fontSize: 24,
                  fontFamily: kMedium,
                  width: Get.width,
                  onPressed: controller.onLogin,
                ).paddingOnly(bottom: 10),

              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
