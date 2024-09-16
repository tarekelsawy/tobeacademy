import 'package:flutter/material.dart';
import '../../../../../base/base_view.dart';
import '../../../../../local/localization_service.dart';
import '../../../../../models/api/page_attributes.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_themes.dart';
import '../../../../../utils/string_utils.dart';
import '../../../../../widgets/buttons/loading_button.dart';
import '../../../../../widgets/country_code_picker/bin_code/flutter_pin_code_fields.dart';
import '../../../../../widgets/loaders/loader.dart';
import 'phone_pin_controller.dart';
import 'package:get/get.dart';

class PhonePinScreen extends BaseView<PhonePinController> {
  PhonePinScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(transparentAppBar: true, resizeToAvoidBottomInset: true, showLine: false,);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
      init: controller,
      tag: tag,
      assignId: true,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Card(
                        elevation: 0,
                        color: Colors.transparent,
                        margin: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(children: [
                          Text('تحقق',
                                  style: Get.textTheme.displayMedium!
                                      .copyWith(fontSize: 24),
                                  textAlign: TextAlign.center)
                              .paddingOnly(bottom: 10),
                          Text('أدخل الكود الخاص بك هنا الذي تم ارساله الي هذا البريد الالكتروني \n ${controller.email}',
                                  style: Get.textTheme.displayMedium!
                                      .copyWith(fontSize: 14),
                                  textAlign: TextAlign.center)
                              .paddingOnly(bottom: 10),
                          Column(children: [
                            Directionality(
                              textDirection: LocalizationService.isRtl()
                                  ? TextDirection.ltr
                                  : TextDirection.ltr,
                              child: PinCodeFields(
                                controller: controller.pinController,
                                length: 6,
                                animationDuration:
                                    const Duration(milliseconds: 200),
                                animationCurve: Curves.easeInOut,
                                fieldBackgroundColor: Colors.transparent,
                                activeBackgroundColor: Colors.transparent,
                                switchInAnimationCurve: Curves.easeIn,
                                switchOutAnimationCurve: Curves.easeOut,
                                textStyle: Get.textTheme.headlineLarge!
                                    .copyWith(fontSize: 22, color: kPrimary),
                                animation: Animations.slideInDown,
                                keyboardType: const TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                activeBorderColor: kPrimary,
                                // onComplete: (output) {
                                //   print(output);
                                // },
                              ).paddingSymmetric(horizontal: 10),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),

                            RoundedLoadingButton(
                                    controller: controller.btnController,
                                    title: 'تحقق',
                                    height: 50,
                                    borderRadius: 15,
                                    progressColor: Get.theme.dividerColor,
                                    onPressed: controller.onVerify,
                                    textColor: kWhite)
                                .paddingSymmetric(horizontal: 20),
                          ])
                        ]).paddingSymmetric(vertical: 24)),
                  ]))),
        );
      }
    );
  }
}
