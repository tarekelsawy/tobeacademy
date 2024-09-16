import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/quezzeis/quiz_details/quiz_details_controller.dart';
import 'package:icourseapp/screens/quezzeis/quiz_details/quiz_item.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_lottie.dart';
import 'package:icourseapp/utils/string_utils.dart';
import 'package:lottie/lottie.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/loaders/shimmer/shimmer_list_loader.dart';
import '../../../widgets/swipeable_list_view.dart';

class QuizDetailsScreen extends BaseView<QuizDetailsController> {
  QuizDetailsScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: controller.quiz.title, doLogout: true);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        assignId: true,
        builder: (_) => Obx(
              () => Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Visibility(
                      visible: !_.isFinished.value && _.seconds.value != 0,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: StringUtils.timeFromSeconds(_.seconds.value),
                            style: Get.textTheme.displayLarge?.copyWith(
                              color: kPrimary,
                              fontSize: 30,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ShimmerListLoader(
                      controller: _,
                      height: 50,
                      radius: 8,
                      horizontal: 20,
                      child: SwipeableListView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          controller: _,
                          itemsCount: _.questions.length,
                          itemBuilder: (context, index) {
                            return QuizItem(
                              isFinished: _.isFinished.value,
                              questionNum: index + 1,
                              questions: _.questions[index],
                              onValueChange: _.onSelectedQuestion,
                              mapData: _.sendingQuestions,
                            ).paddingOnly(bottom: 10);
                          }),
                    ),
                  ),
                  // _.isFinished.value
                  //     ? Text(
                  //         'أنهيت الاختبار وقد حصلت علي نتيجه',
                  //         textAlign: TextAlign.center,
                  //         style: Get.textTheme.displayLarge!
                  //             .copyWith(fontSize: 14, color: kPrimary),
                  //       ).paddingOnly(bottom: 15)
                  //     : const SizedBox(),
                  // _.isFinished.value
                  //     ? Text(
                  //         _.score.value,
                  //         style: Get.textTheme.displayLarge!
                  //             .copyWith(fontSize: 20),
                  //       )
                  //     : const SizedBox(),
                  (_.isFinished.value)
                      ? const SizedBox()
                      : RoundedLoadingButton(
                          title: 'إرسال الاجابات',
                          controller: _.btnController,
                          height: 50,
                          borderRadius: 15,
                          width: Get.width,
                          onPressed: _.onSubmit,
                        )
                          .paddingSymmetric(horizontal: 20)
                          .paddingOnly(bottom: 10),
                ],
              ),
            ));
  }

  @override
  Future<bool> onPopup() {
    try {
      if (!controller.isFinished.value) {
        controller.showConfirmationDialog(
            body: 'إذا خرجت الان سيتم احتساب نتيجتك؟',
            okCallback: () async {
              await controller.onSubmit();
              Get.back();
              Get.back();
            },
            lottie: AppLottie.cancelOrder,
            okText: 'خروج');
      } else {
        Get.back();
      }
    } catch (e) {
      Get.back();
    }

    return Future.value(false);
  }
}
