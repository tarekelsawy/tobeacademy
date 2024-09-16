import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/screens/home/tabs/home_tab/home_tab_controller.dart';
import 'package:system_info2/system_info2.dart';
import '../../../../navigation/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/empty_screen.dart';
import '../../../../widgets/loaders/shimmer/card_shimmer_borderd_loader.dart';
import '../../../categories/widgets/categories_widget.dart';
import '../courses/course_item_widget.dart';

class HomeTabScreen extends BaseView<HomeTabController> {
  HomeTabScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(isHome: true, title: 'home'.tr);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<HomeTabController>(
        init: HomeTabController(),
        builder: (controller) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                          'الاقسام',
                          style: Get.textTheme.displayLarge!.copyWith(fontSize: 16),
                      ),

                      InkWell(
                        onTap: () =>
                            Get.toNamed(Routes.organizations),
                        child: Text(
                          'المزيد',
                          style: Get.textTheme.displayLarge!
                              .copyWith(fontSize: 16, color: kPrimary),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20).paddingOnly(top: 20),
                  Obx(() => controller.loading.value
                      ? const CardShimmerBorderedLoader(
                          height: 150,
                          width: 200,
                          radius: 20,
                        ).paddingSymmetric(horizontal: 20, vertical: 10)
                      : SizedBox(
                          height: 180,
                          child: controller.organization.isEmpty
                              ? const EmptyWidget(
                                  text: 'لا توجد تصنيفات',
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: controller.organization
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 10),
                                              child: CategoriesWidget(
                                                  onTap: controller
                                                      .onNavigateToCategoriesArgs,
                                                  height: 100,
                                                  category: Category(
                                                      id: e.id,
                                                      name: e.name,
                                                      image: e.image, courseCount: e.courseCount)),
                                            ))
                                        .toList(),
                                  ).paddingSymmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                        )),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'الكورسات المميزه',
                        style:
                            Get.textTheme.displayLarge!.copyWith(fontSize: 16),
                      )),
                      InkWell(
                        onTap: () =>
                            Get.toNamed(Routes.filteredCourse, arguments: 1),
                        child: Text(
                          'المزيد',
                          style: Get.textTheme.displayLarge!
                              .copyWith(fontSize: 16, color: kPrimary),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 20, vertical: 10),
                  Obx(() => controller.loadFeaturedCourse.value
                      ? CardShimmerBorderedLoader(
                          height: 310,
                          width: Get.width - 40,
                          radius: 20,
                        ).paddingSymmetric(horizontal: 20, vertical: 10)
                      : SizedBox(
                          height: 310,
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
                                                onTap:
                                                    controller.onCourseNavigate,
                                              ),
                                            ))
                                        .toList(),
                                  ).paddingSymmetric(
                                      horizontal: 20, vertical: 10),
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
                        onTap: () =>
                            Get.toNamed(Routes.filteredCourse, arguments: 2),
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
                          height: 310,
                          width: Get.width - 40,
                          radius: 20,
                        ).paddingSymmetric(horizontal: 20, vertical: 10)
                      : SizedBox(
                          height: 310,
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
                                                onTap:
                                                    controller.onCourseNavigate,
                                              ),
                                            ))
                                        .toList(),
                                  ).paddingSymmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                        )),
                ],
              ),
            ));
  }
}
