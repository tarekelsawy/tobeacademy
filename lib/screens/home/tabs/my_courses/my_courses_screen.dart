import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/tabs/courses/course_item_widget.dart';
import 'package:icourseapp/screens/home/tabs/courses/courses_controller.dart';
import 'package:icourseapp/screens/home/tabs/my_courses/my_courses_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/must_logged_in.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

import '../../../../widgets/star_rating.dart';

class MyCoursesScreen extends BaseView {
  MyCoursesScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(isHome: true, title: 'my_courses'.tr);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<MyCoursesController>(
        init: MyCoursesController(),
        builder: (controller) =>
            !controller.isLoggedIn()
                ? const MustLoggedIn()
                :
            ShimmerListLoader(
              controller: controller,
              height: 270,
              radius: 20,
              horizontal: 20,
              child: SwipeableListView(
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () => controller
                          .onCourseNavigate(controller.courses[index]),
                      child: Card(
                        color: pref.darkTheme ? kPrimary18 : kWhite,
                        shadowColor: !pref.darkTheme ? kPrimary18 : kWhite,
                        elevation: 2,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: controller.courses[index].image ?? '',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, val) => Image.asset(
                                  AppImages.logo,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.courses[index].title ?? '',
                                  style: Get.textTheme.displayMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '${controller.courses[index].lessonsCount ?? '0'} درس',
                                  style: Get.textTheme.displayMedium!
                                      .copyWith(fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    StarRating(
                                      rating: controller
                                              .courses[index].averageRating ??
                                          0,
                                      iconSize: 14,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                        child: Text(
                                      ' (${controller.courses[index].averageRating ?? 0}) تقييم',
                                      style: Get.textTheme.displayMedium!
                                          .copyWith(fontSize: 14),
                                    )),
                                  ],
                                ),
                              ],
                            )),
                            const BaseTextButton(
                              title: 'دخول',
                              height: 35,
                              width: 60,
                              radius: 10,
                              fontSize: 11,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 12, vertical: 8),
                      )).paddingOnly(bottom: 10);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                controller: controller,
                itemsCount: controller.courses.length,
              ),
            ));
  }
}
