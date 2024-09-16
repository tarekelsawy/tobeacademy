import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/extensions/string_extension.dart';
import 'package:icourseapp/widgets/star_rating.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  final ValueChanged<Course> onTap;
  const CourseWidget({Key? key, required this.course, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap.call(course),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
              color: Get.theme.textTheme.displayMedium?.color ?? kPrimary,
              width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: course.image ?? AppImages.failUrl,
                alignment: Alignment.center,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, data) => CachedNetworkImage(
                  imageUrl: AppImages.failUrl,
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SpinKitCircle(
                      color: kPrimary,
                      size: 30,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: SpinKitCircle(
                    color: kPrimary,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          course.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: kPrimary
                          ),
                        ),
                      ),
                      Text(
                        (course.learnerAccessibility != Accessibility.free)?  course.price?.price ?? '':'مجاني',
                        style: Get.textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: kPrimary
                        ),
                      ),
                    ],
                  ),
                  Text(
                    course.subtitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.displayMedium!.copyWith(
                        fontSize: 12,
                        color: pref.darkTheme? kWhite:kGreyBA
                    ),
                  ),
                  Text(
                      'بواسطة ${course.instructor?.firstName??''} ${course.instructor?.lastName??''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarRating(rating: course.averageRating??0,iconSize: 10,),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                color: kPrimary,
                shape: BoxShape.circle
              ),
              child: Transform.rotate(
                  angle: 200,
                  child: Transform.translate(
                      offset: const Offset(1.3, 0),
                      child: Image.asset(AppImages.icPlay,height: 20,).paddingAll(8))),
            ).paddingSymmetric(horizontal: 10),
          ],
        ),
      ).paddingOnly(bottom: 10),
    );
  }
}
