import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/models/course_review.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import 'package:icourseapp/widgets/star_rating.dart';

class UserRatingWidget extends StatelessWidget {
  final CourseReview userReviews;
  const UserRatingWidget({Key? key, required this.userReviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
            child: SizedBox.fromSize(
          size: const Size.fromRadius(20),
          child: CachedNetworkImage(
            imageUrl: userReviews.user?.image??AppImages.avatar,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Loader(),
          ),
        )),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userReviews.user?.name ?? 'not_specific'.tr,
                        style:
                            Get.textTheme.displayMedium?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      StarRating(
                        rating: userReviews.rating.toDouble(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                userReviews.comment??'',

                style: Get.textTheme.displaySmall?.copyWith(
                    color: Get.textTheme.displayMedium?.color?.withOpacity(0.6),
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 10);
  }
}
