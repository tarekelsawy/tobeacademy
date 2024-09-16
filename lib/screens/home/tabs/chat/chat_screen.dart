import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/tabs/chat/chat_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';

import '../../../../widgets/loaders/shimmer/shimmer_list_loader.dart';
import '../../../../widgets/must_logged_in.dart';
import '../../../../widgets/swipeable_list_view.dart';

class ChatScreen extends BaseView {
  ChatScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(isHome: true, title: 'المحادثات');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
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
                      onTap: () =>
                          controller.onNavigateTo(controller.contacts[index]),
                      child: Card(
                        color: pref.darkTheme ? kPrimary18 : kWhite,
                        shadowColor: !pref.darkTheme ? kPrimary18 : kWhite,
                        elevation: 2,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                  controller.contacts[index].image),
                            ),
                            const SizedBox(width: 8,),
                            Expanded(child: Text(controller.contacts[index].name,style: Get.textTheme.displayMedium!.copyWith(fontSize: 14,fontWeight: FontWeight.w700),)),
                                  (controller.contacts[index].unreadMessagesCount > 0)
                                      ? Container(
                                          height: 18,
                                          width: 18,
                                          decoration: const BoxDecoration(
                                              color: kWhite, shape: BoxShape.circle),
                                          child: Center(
                                            child: Text(
                                              controller
                                                  .contacts[index].unreadMessagesCount
                                                  .toString(),
                                              style: Get.textTheme.displayMedium!
                                                  .copyWith(
                                                      height: 1,
                                                      fontSize: 14,
                                                      color: kPrimary),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                          ],
                        ).paddingSymmetric(horizontal: 12, vertical: 8),
                      ).paddingOnly(bottom: 10),
                    );
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  controller: controller,
                  itemsCount: controller.contacts.length,
                ),
              ));
  }
}
