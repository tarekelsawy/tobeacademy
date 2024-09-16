import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/tabs/courses/course_item_widget.dart';
import 'package:icourseapp/screens/search/search_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class SearchScreen extends BaseView {
  SearchScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: 'البحث');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<AppSearchController>(
        init: AppSearchController(),
        global: false,
        assignId: true,
        builder: (controller) => Column(
              children: [
                const SizedBox(height: 10,),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: pref.darkTheme ? kWhite : kBlack)),
                    child: BaseTextField(
                      hintTxt: 'ابحث عن كورس؟',
                      fontSize: 14,
                      controller: controller.search,
                      onChange: controller.onSearch,
                    )).paddingSymmetric(horizontal: 20),
                Expanded(
                  child: ShimmerListLoader(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      controller: controller,
                      itemsCount: controller.courses.length,
                    ),
                  ),
                ),
              ],
            ));
  }
}
