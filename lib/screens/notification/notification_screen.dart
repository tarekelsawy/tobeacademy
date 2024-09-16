import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/screens/notification/notification_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/utils/date_time_util.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

import '../../widgets/must_logged_in.dart';

class NotificationScreen extends BaseView<NotificationController> {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: 'الاشعارات');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: controller,
        tag: tag,
        global: false,
        assignId: true,
        builder: (_) => !_.isLoggedIn()
            ? const MustLoggedIn()
            : ShimmerListLoader(
                controller: _,
                height: 100,
                radius: 20,
                horizontal: 20,
                child: SwipeableListView(
                  emptyWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.emptyNotification)
                          .paddingOnly(bottom: 10),
                      Text(
                        'لا يوجد إشعارات',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.displayMedium!
                            .copyWith(height: 1.6, fontSize: 16),
                      ),
                    ],
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: kPrimary, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.notifications,
                              color: kWhite,
                              size: 30,
                            ).paddingAll(8),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                _.notifications[index].subject,
                                style: Get.textTheme.displayLarge!
                                    .copyWith(fontSize: 16),
                              ),
                              Text(
                                _.notifications[index].message,
                                style: Get.textTheme.displayMedium!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                DateTimeUtil.toddMMYYYYHHMMFormat(
                                    _.notifications[index].createdAt),
                                style: Get.textTheme.displayMedium!.copyWith(
                                    fontSize: 10,
                                    color: Get.textTheme.displayMedium!.color!
                                        .withOpacity(0.7)),
                              ),
                            ],
                          ))
                        ],
                      ).paddingAll(8),
                    ).paddingOnly(bottom: 10);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: _,
                  itemsCount: _.notifications.length,
                ),
              ));
  }
}
