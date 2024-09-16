import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/tabs/courses/course_item_widget.dart';
import 'package:icourseapp/screens/home/tabs/courses/courses_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/empty_screen.dart';
import 'package:icourseapp/widgets/loaders/shimmer/card_shimmer_borderd_loader.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class CoursesScreen extends BaseView {
  CoursesScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(isHome: true, title: 'courses'.tr);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<CoursesController>(
        init: CoursesController(),
        builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'الكورسات المميزه',
                        style:
                            Get.textTheme.displayLarge!.copyWith(fontSize: 16),
                      )),
                      InkWell(
                        onTap: ()=> Get.toNamed(Routes.filteredCourse,arguments: 1),
                        child: Text(
                          'المزيد',
                          style: Get.textTheme.displayLarge!
                              .copyWith(fontSize: 16, color: kPrimary),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20, vertical: 10),
                  Obx(() => controller.loading.value
                      ? CardShimmerBorderedLoader(
                          height: 260,
                          width: Get.width - 40,
                          radius: 20,
                        ).paddingSymmetric(horizontal: 20, vertical: 10)
                      : SizedBox(
                          height: 270,
                          child: controller.featuredCourses.isEmpty
                              ? const EmptyWidget(
                                  text: 'لا توجد كورسات',
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: controller.featuredCourses
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 10),
                                              child: CourseItemWidget(
                                                course: e,
                                                onTap: controller.onCourseNavigate,
                                              ),
                                            ))
                                        .toList(),
                                  ).paddingSymmetric(horizontal: 20, vertical: 10),
                                ),
                        )).paddingOnly(bottom: 20),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'الكورسات الجديده',
                        style:
                            Get.textTheme.displayLarge!.copyWith(fontSize: 16),
                      )),
                      InkWell(
                        onTap: ()=> Get.toNamed(Routes.filteredCourse,arguments: 2),
                        child: Text(
                          'المزيد',
                          style: Get.textTheme.displayLarge!
                              .copyWith(fontSize: 16, color: kPrimary),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20, vertical: 10),
                  Obx(() => controller.loadNewCourse.value
                      ? CardShimmerBorderedLoader(
                          height: 270,
                          width: Get.width - 40,
                          radius: 20,
                        ).paddingSymmetric(horizontal: 20, vertical: 10)
                      : SizedBox(
                          height: 270,
                          child: controller.newCourses.isEmpty
                              ? const EmptyWidget(
                                  text: 'لا توجد كورسات',
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: controller.newCourses
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 10),
                                              child: CourseItemWidget(
                                                course: e,
                                                onTap: controller.onCourseNavigate,
                                              ),
                                            ))
                                        .toList(),
                                  ).paddingSymmetric(horizontal: 20, vertical: 10),
                                ),
                        )),
                ],
              ),
            ));
  }
}
