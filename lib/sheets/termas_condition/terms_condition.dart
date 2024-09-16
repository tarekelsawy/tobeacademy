import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/sheets/termas_condition/terms_condition_controller.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import '../../theme/app_colors.dart';
import '../../widgets/buttons/base_text_button.dart';

class TermsConditionSheet extends StatefulWidget {

  const TermsConditionSheet({Key? key}) : super(key: key);

  @override
  _TermsConditionSheetState createState() => _TermsConditionSheetState();
}

class _TermsConditionSheetState extends State<TermsConditionSheet> {

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<TermsConditionController>(
        init: TermsConditionController(),
        builder: (cont) {
          return Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              ),
              child: SafeArea(
                child: Obx(
                    ()=> cont.loading.value? const Center(child: Loader(),): SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'الشروط والأحكام',
                            style: Get.textTheme.displayMedium!
                                .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                          ).paddingSymmetric(horizontal: 16),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          Column(children: cont.privacy.map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title ?? '',
                                style: Get.textTheme.displayLarge!.copyWith(fontSize: 20),
                              ).paddingOnly(bottom: 10).paddingSymmetric(horizontal: 10),
                              Text(
                                e.description ?? '',
                                style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),
                              ).paddingOnly(bottom: 10,left: 10,right: 10)
                            ],
                          ).paddingOnly(bottom: 10)).toList(),),
                          BaseTextButton(
                              onPress:() {
                                Get.back();
                              },
                              radius: 12,
                              title:  'اغلاق'.tr).paddingSymmetric(horizontal: 16)
                        ]).paddingSymmetric(vertical: 16),
                  ),
                ),
              ));
        }
      );
  }
}
