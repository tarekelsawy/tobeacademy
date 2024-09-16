import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/filtered_courses/filtered_course_controller.dart';
import 'package:icourseapp/screens/home/tabs/courses/course_item_widget.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class FilteredCourseScreen extends BaseView<FilteredCourseController> {
   FilteredCourseScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: controller.args == 1? 'الكورسات المميزه': 'الكورسات الجديده');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<FilteredCourseController>(
        init: controller,
        tag: tag,
        global: false,
        assignId: true,
        builder: (controller) =>  ShimmerListLoader(
          controller: controller,
          height: 270,
          radius: 20,
          horizontal: 20,
          child: SwipeableListView(
            itemBuilder: (context, index) {
              return CourseItemWidget(
                course: controller.courses[index],
                onTap: controller.onCourseNavigate,
              );
            },
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            controller: controller,
            itemsCount: controller.courses.length,
          ),
        ));
  }


}
