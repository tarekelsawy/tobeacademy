import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/tabs/courses/course_item_widget.dart';
import 'package:icourseapp/screens/home/tabs/live_sessions/live_sessions_controller.dart';
import 'package:icourseapp/utils/date_time_util.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/must_logged_in.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

import '../../../../theme/app_colors.dart';

class LiveSessionsScreen extends BaseView {
  LiveSessionsScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(isHome: true, title: 'live_sessions'.tr);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<LiveSessionsController>(
        init: LiveSessionsController(),
        builder: (controller) => !controller.isLoggedIn()
            ? const MustLoggedIn()
            : ShimmerListLoader(
                controller: controller,
                height: 45,
                radius: 12,
                horizontal: 20,
                child: SwipeableListView(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => controller
                          .onCourseNavigate(controller.sessions[index]),
                      child: Container(
                        height: 45,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.live_tv_rounded,
                              color: kWhite,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              controller.sessions[index].title,
                              style: Get.textTheme.displayMedium!
                                  .copyWith(fontSize: 14, color: kWhite),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                DateTimeUtil.toddMMYYYYHHMMAFormat(
                                  controller.sessions[index].classDate,
                                ),
                                style: Get.textTheme.displayMedium!
                                    .copyWith(fontSize: 12, color: kWhite),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: kWhite,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 10),
                      ).paddingOnly(bottom: 10),
                    );
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller,
                  itemsCount: controller.sessions.length,
                ),
              ));
  }
}
