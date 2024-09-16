import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/account_screens/privacy/privacy_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

class PrivacyScreen extends BaseView<PrivacyController> {
  PrivacyScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: 'الشروط والأحكام',showNav: false);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
      init: controller,
      tag: tag,
      global: false,
      assignId: true,
      builder: (_) {
        return Obx(
            ()=> _.loading.value? const Center(child: SpinKitCubeGrid(color: kPrimary,size: 30,),): SwipeableListView(
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _.privacy[index].title ?? '',
                    style: Get.textTheme.displayLarge!.copyWith(fontSize: 20),
                  ).paddingOnly(bottom: 10).paddingSymmetric(horizontal: 10),
                 Text(
                      _.privacy[index].description ?? '',
                      style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),
                    ).paddingOnly(bottom: 10,left: 10,right: 10)
                ],
              ).paddingOnly(bottom: 10);
            },
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            controller: _,
            itemsCount: _.privacy.length,
          ),
        );
      }
    );
  }
}
