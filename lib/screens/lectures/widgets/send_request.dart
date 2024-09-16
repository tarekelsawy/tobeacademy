import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';

import '../../../theme/app_themes.dart';
import '../../../widgets/base_text_field.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../courses/course_details/course_details_repository.dart';

class SendRequest extends StatefulWidget {
  final int lessonId;
  final int courseId;

  const SendRequest({Key? key, required this.lessonId, required this.courseId})
      : super(key: key);

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController code = TextEditingController();
  onSendRequest() async {
    if(code.text.trim().isEmpty){
      btnController.start();
      var resource = await CourseDetailsRepository().sendRequest(
          courseId: widget.courseId.toString(),
          sectionId: widget.lessonId.toString());
      btnController.stop();
      if (resource.isSuccess()) {
        Get.back();
        HomeController().showSuccessMessage(resource.data);
      }
      return;
    }
    if (!formKey.currentState!.validate()) return;
    btnController.start();
    var resource = await CourseDetailsRepository().sendRequestWithCode(
        courseId: widget.courseId.toString(),
        code: code.text,
        sectionId: widget.lessonId.toString());
    btnController.stop();
    if (resource.isSuccess()) {
      Get.back();
      HomeController().showSuccessMessage(resource.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'إرسال طلب إشتراك',
              style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),
            ).paddingOnly(bottom: 10),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: pref.darkTheme ? kWhite : kBlack),
                            borderRadius: BorderRadius.circular(15)),
                        child: BaseTextField(
                          validator: (value) =>
                              value != null && value.isEmpty ? 'مطلوب' : null,
                          hintTxt: 'أدخل كود الاشتراك',
                          controller: code,
                          fontSize: 12,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundedLoadingButton(
                  title: 'إرسال طلب',
                  controller: btnController,
                  height: 50,
                  borderRadius: 15,
                  color: kPrimaryGreen,
                  fontSize: 16,
                  fontFamily: kMedium,
                  width: 100,
                  onPressed: onSendRequest,
                )
              ],
            )
          ],
        ).paddingSymmetric(vertical: 10),
      ),
    );
  }
}
