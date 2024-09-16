import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/courses/course_details/screens/rate/rate_controller.dart';
import 'package:icourseapp/screens/courses/course_details/widget/user_rating_widget.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

import '../../../../../widgets/buttons/base_text_button.dart';

class RateScreen extends BaseView<RateController> {
  RateScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: 'التقييمات');

  @override
  buildBody(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetBuilder(
                  init: controller,
                  tag: tag,
                  global: false,
                  assignId: true,
                  builder: (_) {
                    return ShimmerListLoader(
                      shimmerLoaderType: ShimmerLoaderType.linearCircular,
                      controller: _,
                      child: SwipeableListView(
                        controller: _,
                        itemsCount: _.reviews.length,
                        itemBuilder: (context, index) => UserRatingWidget(userReviews: _.reviews[index],).paddingSymmetric(horizontal: 20),
                      ),
                    );
                  }),
            ),
            if (controller.isLoggedIn())
             BaseTextButton(
                  title: 'تقييم',
                  onPress: controller.onRateUsers,
                  radius: 10,
                  backgroundColor: kPrimaryGreen,
                  borderColor: Colors.transparent,
                  height: 45,
                ).paddingSymmetric(horizontal: 20,vertical: 10).paddingOnly(bottom: 10),

          ],
        ));
  }
}
