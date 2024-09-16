import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/quiz_args.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/courses/course_details/course_details_controller.dart';
import 'package:icourseapp/screens/courses/course_details/widget/user_rating_widget.dart';
import 'package:icourseapp/screens/player/player_screen.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/extensions/string_extension.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import 'package:icourseapp/widgets/loaders/shimmer/circular_shimmer_loader.dart';
import 'package:icourseapp/widgets/star_rating.dart';

import '../../../widgets/empty_screen.dart';

class CourseDetailsScreen extends BaseView<CourseDetailsController> {
  CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(
      title: controller.course.title, resizeToAvoidBottomInset: true);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
        init: controller,
        global: false,
        assignId: true,
        tag: tag,
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(25),
                      child: SizedBox(
                        height: 230,
                        width: Get.width,
                        child:  CachedNetworkImage(
                                imageUrl: _.course.image ?? AppImages.failUrl,
                                fit: BoxFit.cover,
                                // placeholder: (context, url) => const Loader(),
                              )
                      ),
                    ).paddingSymmetric(vertical: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '',
                                        style: Get.textTheme.displayMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: kPrimary),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${_.course.instructor?.firstName}',
                                        style: Get.textTheme.displayMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.work,
                              //       color: kGrey57,
                              //       size: 15,
                              //     ),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     Text(
                              //       _.course.instructor?.professionalTitle ?? '',
                              //       style: Get.textTheme.displayMedium!
                              //           .copyWith(fontSize: 14),
                              //     )
                              //   ],
                              // ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.info,
                                    color: kGrey57,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _.course.instructor?.aboutMe ?? '',
                                      style: Get.textTheme.displayMedium!
                                          .copyWith(fontSize: 14,height: 1.2),
                                    ),
                                  )
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.email,
                              //       color: kGrey57,
                              //       size: 15,
                              //     ),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     Text(
                              //       _.course.instructor?.email ?? '',
                              //       style: Get.textTheme.displayMedium!
                              //           .copyWith(fontSize: 14),
                              //     )
                              //   ],
                              // ),

                            ],
                          ),
                        ),
                        if (_.course.learnerAccessibility != Accessibility.free)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '(${_.course.averageRating?.toStringAsFixed(1)})',
                                    style: Get.textTheme.displayMedium!
                                        .copyWith(fontSize: 14),
                                  ),
                                   StarRating(
                                    starCount: 5,
                                    rating: _.course.averageRating ?? 0,
                                  ),
                                ],
                              ),
                              Text(
                                _.course.price?.price ?? '',
                                style: Get.textTheme.displayMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: kPrimary),
                              ),
                            ],
                          ),
                      ],
                    ).paddingOnly(bottom: 10),

                    Container(
                      height: 0.5,
                      width: Get.width,
                      color: Get.textTheme.displayMedium!.color!,
                    ).paddingSymmetric(vertical: 10),
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'الوصف',
                          style: Get.textTheme.displayMedium!.copyWith(
                              color: kPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          _.course.description ?? '',
                          style: Get.textTheme.displayMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Get.textTheme.displayMedium!.color!
                                  .withOpacity(0.7)),
                        )),
                    if ((_.isLoggedIn() && (_.course.isEnrollemnt ?? false)) ||
                        (_.course.learnerAccessibility == Accessibility.free))
                      Container(
                        height: 0.5,
                        width: Get.width,
                        color: Get.textTheme.displayMedium!.color!,
                      ).paddingSymmetric(vertical: 10),
                    if ((_.isLoggedIn() && (_.course.isEnrollemnt ?? false))|| (_.course.learnerAccessibility == Accessibility.free))
                    InkWell(
                      onTap: () {
                        if (!controller.isLoggedInWithSheet()) return;
                        //_.stopVideo();
                        Get.toNamed(Routes.files, arguments: _.course);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'الملفات',
                              style: Get.textTheme.displayMedium!.copyWith(
                                  color: kPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Get.textTheme.displayMedium!.color!,
                          ),
                        ],
                      ),
                    ),
                    if ((_.isLoggedIn() && (_.course.isEnrollemnt ?? false)) ||
                        (_.course.learnerAccessibility == Accessibility.free))
                      Container(
                        height: 0.5,
                        width: Get.width,
                        color: Get.textTheme.displayMedium!.color!,
                      ).paddingSymmetric(vertical: 10),
                    if ((_.isLoggedIn() && (_.course.isEnrollemnt ?? false)) ||
                        (_.course.learnerAccessibility == Accessibility.free))
                      InkWell(
                        onTap: () {
                          if (!controller.isLoggedInWithSheet()) return;
                          //_.stopVideo();
                          Get.toNamed(Routes.quiz,
                              arguments: QuizArgs(
                                  modelId: _.course.id!, isCourse: true));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'الاختبارات',
                                style: Get.textTheme.displayMedium!.copyWith(
                                    color: kPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Get.textTheme.displayMedium!.color!,
                            ),
                          ],
                        ),
                      ),
                    if ((_.isLoggedIn() && (_.course.isEnrollemnt ?? false)) ||
                        (_.course.learnerAccessibility == Accessibility.free))
                      Container(
                        height: 0.5,
                        width: Get.width,
                        color: Get.textTheme.displayMedium!.color!,
                      ).paddingSymmetric(vertical: 10),
                    if ((_.isLoggedIn() && (_.course.isEnrollemnt ?? false)) ||
                        (_.course.learnerAccessibility == Accessibility.free))
                      InkWell(
                        onTap: () {
                          if (!controller.isLoggedInWithSheet()) return;
                          //_.stopVideo();
                          Get.toNamed(Routes.announcement, arguments: _.course);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'إعلان',
                                style: Get.textTheme.displayMedium!.copyWith(
                                    color: kPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Get.textTheme.displayMedium!.color!,
                            ),
                          ],
                        ),
                      ),
                    Container(
                      height: 0.5,
                      width: Get.width,
                      color: Get.textTheme.displayMedium!.color!,
                    ).paddingSymmetric(vertical: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'التقييمات',
                            style: Get.textTheme.displayMedium!.copyWith(
                                color: kPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  //_.stopVideo();
                                  Get.toNamed(Routes.rate, arguments: _.course);
                                },
                                child: Text(
                                  'مشاهده المزيد',
                                  style: Get.textTheme.displayMedium!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: kPrimary),
                                )),
                            const Icon(Icons.arrow_forward_ios, color: kPrimary,),
                          ],
                        )
                      ],
                    ).paddingOnly(bottom: 10),
                    Obx(
                      () => _.loadReviews.value
                          ? const SizedBox(
                              height: 300,
                              child: CircularShimmerLoader(
                                numOfItem: 5,
                              ))
                          : _.reviews.isEmpty
                              ? const EmptyWidget(
                                  text: 'لا يوجد تقييمات',
                                )
                              : SizedBox(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: _.reviews
                                          .map((e) => UserRatingWidget(
                                                userReviews: e,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                    ).paddingOnly(bottom: 10),

                    Column(
                      children: [
                        (!(_.course.isEnrollemnt ?? false))
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      if (_.course.learnerAccessibility !=
                                          Accessibility.free)
                                        Expanded(
                                          child: Form(
                                            key: _.formKey,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: pref.darkTheme
                                                            ? kWhite
                                                            : kBlack),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: BaseTextField(
                                                  validator: (value) =>
                                                      value != null &&
                                                              value.isEmpty
                                                          ? 'مطلوب'
                                                          : null,
                                                  hintTxt: 'أدخل كود الاشتراك',
                                                  controller: _.code,
                                                  fontSize: 12,
                                                )),
                                          ),
                                        ),
                                      if (_.course.learnerAccessibility !=
                                          Accessibility.free)
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      if (_.course.learnerAccessibility !=
                                          Accessibility.free)
                                        Expanded(
                                          child: RoundedLoadingButton(
                                            title: 'إرسال طلب',
                                            controller: _.btnController,
                                            height: 50,
                                            borderRadius: 15,
                                            color: kPrimaryGreen,
                                            fontSize: 16,
                                            fontFamily: kMedium,
                                            onPressed: _.onSendRequest,
                                          ),
                                        ),
                                    ],
                                  ).paddingOnly(bottom: 10),
                                ],
                              )
                            : const SizedBox(),
                        BaseTextButton(
                          backgroundColor: Get.theme.scaffoldBackgroundColor,
                          txtColor: kPrimary,
                          title: 'مشاهده الدروس (${controller.course.lecturesCount??''}) درس',
                          onPress: _.onShowLectures,
                          radius: 15,
                        ).paddingOnly(bottom: 20),
                      ],
                    )
                  ],
                ).paddingSymmetric(horizontal: 20, vertical: 10)),
              ),
              const SafeArea(
                child: SizedBox(),
              ),
            ],
          );
        });
  }
}
