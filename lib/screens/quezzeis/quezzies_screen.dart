import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/quezzeis/quezzies_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class QuizzesScreen extends BaseView<QuezziesController> {
  QuizzesScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: 'الاختبارات');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        assignId: true,
        builder: (_) => ShimmerListLoader(
          controller: _,
          height: 50,
          radius: 8,
          horizontal: 20,
          child: SwipeableListView(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              controller: _,
              itemsCount: _.quizzes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: ()=> _.onNavigateToQuizDetails(_.quizzes[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: pref.darkTheme? kWhite:kBlack),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_.quizzes[index].title,style: Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700,fontSize: 16),).paddingOnly(bottom: 10),
                              Text(_.quizzes[index].createdAt,style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),).paddingOnly(bottom: 10),
                            ],
                          )),
                          Column(
                            children: [
                              Text(_.quizzes[index].quizTimeMinute.toString(),style: Get.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700,fontSize: 20, color: kPrimary),).paddingOnly(bottom: 10),
                              Text('دقيقه',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14, color: kPrimary),).paddingOnly(bottom: 10),
                            ],
                          ),
                        ],),
                        Container(
                          color: pref.darkTheme? kWhite:kBlack,
                          height: 1,
                          width: Get.width,
                        ).paddingSymmetric(vertical: 10),
                        const BaseTextButton(title: 'ابدأ',height: 35, width: 80,radius: 8,),
                      ],
                    ).paddingSymmetric(vertical: 8,horizontal: 12),
                  ),
                ).paddingOnly(bottom: 10);
              }),
        ));
  }
}


