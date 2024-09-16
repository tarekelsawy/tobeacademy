import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/courses/categories_courses_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

import '../home/tabs/courses/course_item_widget.dart';

class CategoriesCoursesScreen extends BaseView<CategoriesCoursesController> {
   CategoriesCoursesScreen({Key? key}) : super(key: key);


  @override
  PageAttributes get pageAttributes => PageAttributes(title: controller.args.name);

   @override
   Widget buildBody(BuildContext context) {
     return GetBuilder<CategoriesCoursesController>(
         init: controller,
         global: false,
         tag: tag,
         assignId: true,
         builder: (_)=> ShimmerListLoader(
           controller: _,
           height: 270,
           radius: 20,
           horizontal: 20,
           child: SwipeableListView(
             itemBuilder: (context, index) {
               return CourseItemWidget(
                 onTap: _.onNavigateToDetails,
                   course: _.courses[index]);
             },
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
             controller: _,
             itemsCount: _.courses.length,
           ),
         ));
   }

   @override
  List<Widget> buildAppbarActions() {
    return [
      InkWell(
        onTap: controller.onFilter,
        child: Row(
          children: [
            Text('تصفيه',style: Get.textTheme.displayMedium!.copyWith(fontSize: 16,color: !pref.darkTheme? kGreyA9: kWhite),),
            const SizedBox(width: 5,),
            const Icon(Icons.filter_alt,color: kGreyA9,),
          ],
        ).paddingSymmetric(horizontal: 20),
      )

    ];
  }
}

