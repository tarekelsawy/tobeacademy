import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/auth/register/register_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:icourseapp/utils/validation.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';
import 'package:icourseapp/widgets/dropdown/drop_down.dart';
import '../../../main.dart';
import '../../../models/classes.dart';
import '../../../widgets/circular_avatar.dart';

class RegisterScreen extends BaseView<RegisterController> {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(
      title: (controller.args == null)
          ? 'إنشاء حساب جديد'
          : (controller.args!.action == DataAction.socialLogin)
              ? 'اكمال البيانات'
              : 'تعديل الحساب',
      showLine: false,
      resizeToAvoidBottomInset: true,
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
                  height: 200,
                ).paddingOnly(bottom: 20),
                Obx(
                  () => InkWell(
                    onTap: controller.changeProfilePic,
                    child: SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          CircularAvatar(
                            // onTap: ,
                            avatarUrl: controller.args?.image ??
                                controller.image.value?.path ??
                                pref.client?.image ??
                                AppImages.avatar,
                            fromFile: controller.image.value != null,
                            size: 100,
                          ),
                          SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kWhite.withOpacity(0.5)),
                                  child: Center(
                                      child: Text(
                                    'اختر صوره',
                                    style: Get.textTheme.displayMedium!
                                        .copyWith(fontSize: 14, color: kBlack),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).paddingOnly(bottom: 10),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  'الاسم الاول'.tr,
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
                              validator: ValidationUtil.validateString,
                              hintTxt: '',
                              controller: controller.firstName,
                              enabled: (controller.args == null)
                                  ? true
                                  : (controller.args!.action ==
                                          DataAction.socialLogin)
                                      ? true
                                      : false,
                            )).paddingOnly(bottom: 20),
                      ],
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  'الاسم الاخير'.tr,
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
                              validator: ValidationUtil.validateString,
                              hintTxt: '',
                              controller: controller.lastName,
                              enabled: (controller.args == null)
                                  ? true
                                  : (controller.args!.action ==
                                          DataAction.socialLogin)
                                      ? true
                                      : false,
                            )).paddingOnly(bottom: 20),
                      ],
                    )),
                  ],
                ),
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
                      readOnly: controller.args?.provider != null,
                      validator: ValidationUtil.validateEmail,
                      hintTxt: 'example@example.com',
                      controller: controller.email,
                      textInputType: TextInputType.emailAddress,
                      enabled: (controller.args == null)
                          ? true
                          : (controller.args!.action == DataAction.socialLogin)
                              ? true
                              : false,
                    )).paddingOnly(bottom: 20),
                if (controller.args == null)
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'password'.tr,
                        style: Get.textTheme.displayMedium!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )).paddingOnly(bottom: 5).paddingSymmetric(horizontal: 5),
                if (controller.args == null)
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
                      )).paddingOnly(bottom: 20),
                if (controller.args == null)
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'تأكيد كلمه المرور',
                        style: Get.textTheme.displayMedium!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )).paddingOnly(bottom: 5).paddingSymmetric(horizontal: 5),
                if (controller.args == null)
                  Container(
                      decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        border: Border.all(color: kGreyE2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: BaseTextField(
                        hintTxt: '',
                        validator: (value) =>
                            ValidationUtil.validateConfirmPassword(
                                value, controller.password.text),
                        password: false,
                        obscureText: true,
                        controller: controller.confirmPassword,
                      )).paddingOnly(bottom: 20),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'رقم الهاتف',
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
                      validator: ValidationUtil.validatePhoneNumber,
                      controller: controller.phone,
                      textInputType: TextInputType.phone,
                      enabled: (controller.args == null)
                          ? true
                          : (controller.args!.action == DataAction.socialLogin)
                              ? true
                              : false,
                    )).paddingOnly(bottom: 20),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'العنوان',
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
                      controller: controller.address,
                    )).paddingOnly(bottom: 20),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'المرحله الدراسيه',
                      style: Get.textTheme.displayMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    )).paddingOnly(bottom: 5).paddingSymmetric(horizontal: 5),
                DropDown<Classes>(
                  controller.classes,
                  onChange: controller.onSelectClass,
                  hint: 'المرحله التعليميه',
                  initialValue: controller.classes.firstWhereOrNull(
                      (element) => element.classKey == pref.client?.classes),
                ).paddingOnly(
                    bottom:
                        controller.args?.action == DataAction.edit ? 20 : 5),
                if (controller.args == null ||
                    (controller.args?.action == DataAction.socialLogin))
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.agree.value,
                          onChanged: (val) {
                            controller.agree.value = !controller.agree.value;
                          })),
                      Expanded(
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'أنا أوافق علي',
                              style: Get.textTheme.displayMedium
                                  ?.copyWith(fontSize: 14)),
                          TextSpan(
                              text: ' ${'الشروط والاحكام'} ',
                              recognizer: TapGestureRecognizer()
                                ..onTap = controller.onShowTerms,
                              style: Get.textTheme.displayMedium
                                  ?.copyWith(fontSize: 14, color: kPrimary)),
                        ])),
                      ),
                    ],
                  ).paddingOnly(bottom: 20),
                RoundedLoadingButton(
                  title: (controller.args == null)
                      ? 'إنشاء حساب'
                      : (controller.args!.action == DataAction.socialLogin)
                          ? 'اكمال البيانات'
                          : 'تعديل الحساب',
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
