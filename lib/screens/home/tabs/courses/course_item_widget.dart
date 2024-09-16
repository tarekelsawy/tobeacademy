import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/extensions/string_extension.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/star_rating.dart';

class CourseItemWidget extends StatefulWidget {
  final Course course;
  final ValueChanged<Course> onTap;
  const CourseItemWidget({Key? key, required this.course, required this.onTap})
      : super(key: key);

  @override
  State<CourseItemWidget> createState() => _CourseItemWidgetState();
}

class _CourseItemWidgetState extends State<CourseItemWidget> {
  var category = ''.obs;
  var organization = ''.obs;

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  _getCategory() async {
    category.value = await widget.course.getCategory();
    organization.value = await widget.course.getOrganization();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap.call(widget.course),
      child: Container(
        height: 280,
        width: Get.width - 40,
        decoration: BoxDecoration(
          border: Border.all(
              color: Get.theme.textTheme.displayMedium?.color ?? kPrimary,
              width: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: widget.course.image ?? AppImages.failUrl,
                alignment: Alignment.center,
                height: 140,
                width: Get.width,
                fit: BoxFit.cover,
                errorWidget: (context, url, data) => CachedNetworkImage(
                  imageUrl: AppImages.failUrl,
                  alignment: Alignment.center,
                  height: 140,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SpinKitCircle(
                      color: kPrimary,
                      size: 30,
                    ),
                  ),
                ),
                // placeholder: (context, url) => const Center(
                //   child: SpinKitCircle(
                //     color: kPrimary,
                //     size: 30,
                //   ),
                // ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Obx(
                () => Text(
                  '$organization $category',
                  style: Get.textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: kPrimaryGreen),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.course.title ?? '',
                    style: Get.textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: kPrimary),
                  ),
                ),
                Text(
                  (widget.course.learnerAccessibility != Accessibility.free)
                      ? widget.course.price?.price ?? ''
                      : 'مجاني',
                  style: Get.textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: kPrimary),
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
            Text(
              widget.course.subtitle ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.displayMedium!.copyWith(
                  fontSize: 14, color: pref.darkTheme ? kWhite : kGreyBA),
            ).paddingSymmetric(horizontal: 20),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'بواسطة: ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.course.instructor?.firstName ?? ''} ${widget.course.instructor?.lastName ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: kPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                StarRating(
                  rating: widget.course.averageRating ?? 0,
                  iconSize: 14,
                ),
              ],
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    ).paddingOnly(bottom: 10);
  }
}
