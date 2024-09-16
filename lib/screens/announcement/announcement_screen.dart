import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/announcement/announcement_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementScreen extends BaseView<AnnouncementController> {
  AnnouncementScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: controller.course.title ?? '');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<AnnouncementController>(
        init: controller,
        global: false,
        tag: tag,
        assignId: true,
        builder: (_) => ShimmerListLoader(
              controller: _,
              height: 100,
              radius: 20,
              horizontal: 20,
              child: SwipeableListView(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: _.announcements[index].meetingLink == null
                        ? null
                        : () async {
                            if (!await launchUrl(
                                Uri.parse(_.announcements[index].meetingLink!),
                                mode: LaunchMode.externalApplication)) {
                              throw Exception(
                                  'Could not launch ${_.announcements[index].meetingLink}');
                            }
                          },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.announcement,
                                      color: kPrimary,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      _.announcements[index].title ?? '',
                                      style: Get.textTheme.displayLarge!
                                          .copyWith(fontSize: 16),
                                    )),
                                  ],
                                ),
                                Text(
                                  _.announcements[index].title ?? '',
                                  style: Get.textTheme.displayLarge!
                                      .copyWith(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Get.textTheme.displayLarge!.color!,
                          ),
                        ],
                      ).paddingSymmetric(vertical: 10, horizontal: 20),
                    ).paddingOnly(bottom: 10),
                  ).paddingSymmetric(horizontal: 10);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                controller: _,
                itemsCount: _.announcements.length,
              ),
            ));
  }
}
