import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/quiz.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/radio_button_image_widget.dart';
import 'package:icourseapp/widgets/view_image.dart';

class QuizItem extends StatelessWidget {
  final Questions questions;
  final int questionNum;
  final bool isFinished;
  final List<Questions> mapData;
  final ValueChanged<Questions> onValueChange;
  const QuizItem(
      {Key? key,
      required this.questions,
      required this.onValueChange,
      required this.mapData,
      required this.questionNum,
      required this.isFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          shadowColor: !pref.darkTheme ? kPrimary18 : kWhite,
          color: pref.darkTheme ? kPrimary18 : kWhite,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: !pref.darkTheme ? kPrimary18 : kWhite)),
                    child: Text(
                      questionNum.toString(),
                      style:
                          Get.textTheme.displayMedium!.copyWith(fontSize: 18),
                    ).paddingAll(10),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      questions.question ?? '',
                      style: Get.textTheme.displayMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600,height: 1.3),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 10),
              if (questions.image != null)
                InkWell(
                  onTap: ()=> Get.to(()=> ViewImage(), arguments: questions.image!),
                  child: CachedNetworkImage(
                    imageUrl: questions.image ?? '',
                    height: 150,
                  ).paddingOnly(bottom: 10),
                ),
              Wrap(
                spacing: 8,
                children: List.generate(
                    questions.choices!.length,
                    (index) => Row(
                          children: [
                            Text(
                              '${index + 1}. ',
                              style: Get.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                questions.choices![index].tr,
                                style: Get.textTheme.displayMedium!
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        )),
              ),
              Container(
                height: 1,
                width: Get.width,
                color: pref.darkTheme ? kWhite : kPrimary18,
              ).paddingSymmetric(vertical: 15),
              Row(
                children: [
                  Expanded(
                      child: Wrap(
                          spacing: 8,
                          children: List.generate(
                              questions.choices!.length,
                              (index) => RadioItemImageWidget<String>(
                                    title: '${index + 1}',
                                    isFinished: isFinished,
                                    questionVal: mapData.firstWhereOrNull(
                                        (element) =>
                                            element.id == questions.id),
                                    onChecked: (value) {
                                      onValueChange.call(Questions(
                                          id: questions.id,
                                          choice: value,
                                          degree: questions.degree,
                                          choices: questions.choices,
                                          question: questions.question));
                                    },
                                    item: questions.choices![index],
                                    groupValue: mapData
                                        .firstWhereOrNull((element) =>
                                            element.id == questions.id)
                                        ?.choice,
                                  ).paddingOnly(bottom: 8)))),
                  
                  Text('الدرجه: ${questions.degree}',style: Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700,color: kPrimary,fontSize: 16),)
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 10),
        ),
        // Column(
        //   children: questions.choices!
        //       .map((e) => RadioItemImageWidget<String>(
        //             title: e,
        //             isFinished: isFinished,
        //             questionVal: mapData.firstWhereOrNull(
        //                 (element) => element.id == questions.id),
        //             onChecked: (value) {
        //               onValueChange.call(Questions(
        //                   id: questions.id,
        //                   choice: value,
        //                   choices: questions.choices,
        //                   question: questions.question));
        //             },
        //             item: e,
        //             groupValue: mapData
        //                 .firstWhereOrNull(
        //                     (element) => element.id == questions.id)
        //                 ?.choice,
        //           ).paddingOnly(bottom: 10))
        //       .toList(),
        // ),
      ],
    );
  }
}
