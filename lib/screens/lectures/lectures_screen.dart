import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/screens/lectures/lectures_controller.dart';
import 'package:icourseapp/screens/lectures/widgets/send_request.dart';
import 'package:icourseapp/screens/player/player_screen.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/buttons/base_text_button.dart';
import 'package:icourseapp/widgets/loaders/shimmer/card_shimmer_borderd_loader.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';

import '../../main.dart';
import '../../models/quiz_args.dart';
import '../../theme/app_lottie.dart';

class LecturesScreen extends BaseView<LecturesController> {
  LecturesScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: controller.course.title);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<LecturesController>(
      init: controller,
      assignId: true,
      tag: tag,
      builder: (_) => Obx(
        () => controller.loading.value
            ? Column(
                children: [
                  CardShimmerBorderedLoader(
                    height: 60,
                    width: Get.width,
                    radius: 0,
                  ).paddingOnly(bottom: 20),
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: CardShimmerBorderedLoader(
                      height: 60,
                      width: Get.width - 20,
                      radius: 20,
                    ).paddingOnly(bottom: 10),
                  ),
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: CardShimmerBorderedLoader(
                      height: 60,
                      width: Get.width - 20,
                      radius: 20,
                    ).paddingOnly(bottom: 10),
                  ),
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: CardShimmerBorderedLoader(
                      height: 60,
                      width: Get.width - 20,
                      radius: 20,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  if (_.lessons.isNotEmpty &&
                      _.lessons.first.lectures!.isNotEmpty &&
                      _.lessons.first.lectures!.first.introVideo != null)
                    SizedBox(
                      height: 250,
                      child: PlayerWidget(
                        height: 250,
                        videoType: VideoType.youtube,
                        video: _.lessons.first.lectures!.first.introVideo!,
                        tag: _.lessons.first.lectures!.first.introVideo!,
                      ).paddingOnly(bottom: 20),
                    ).paddingSymmetric(horizontal: 20),
                  Expanded(
                    child: SwipeableListView(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: kPrimaryGreen,
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // if ((_.lessons[index].isEnrollemnt ??
                                      //     false))
                                      const Expanded(child: SizedBox()),
                                      if ((_.lessons[index].isEnrollemnt ??
                                              false) &&
                                          (Get.find<HomeController>().isSecure))
                                        const SizedBox(
                                          width: 35,
                                        ),

                                      Expanded(
                                        child: Text(
                                          _.lessons[index].name ?? '',
                                          style: Get.textTheme.displayLarge!
                                              .copyWith(
                                                  fontSize: 14, color: kWhite),
                                        ),
                                      ),

                                      // if ((_.lessons[index].isEnrollemnt ??
                                      //         false) &&
                                      //     (Get.find<HomeController>().isSecure))
                                      //   const SizedBox(),
                                      // if (!(_.lessons[index].isEnrollemnt ??
                                      //         false) &&
                                      //     (Get.find<HomeController>().isSecure))
                                      if (!(_.lessons[index].isEnrollemnt ??
                                              false) &&
                                          (Get.find<HomeController>().isSecure))
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      (!(_.lessons[index].isEnrollemnt ??
                                                  false) &&
                                              (Get.find<HomeController>()
                                                  .isSecure))
                                          ? BaseTextButton(
                                              title: 'إشتراك',
                                              backgroundColor: kWhite,
                                              txtColor: kPrimary,
                                              onPress: () {
                                                if (!_.isLoggedInWithSheet()) {
                                                  return;
                                                }
                                                Get.bottomSheet(
                                                    SendRequest(
                                                      lessonId:
                                                          _.lessons[index].id ??
                                                              0,
                                                      courseId:
                                                          _.course.id ?? 0,
                                                    ),
                                                    elevation: 4,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    isDismissible: true);
                                              },
                                              width: 100,
                                              radius: 4,
                                              height: 35,
                                            )
                                          : const Expanded(
                                              child: SizedBox(
                                              width: 100,
                                            )),
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: 20, vertical: 10),
                                ).paddingOnly(bottom: 10),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.quiz,
                                        arguments: QuizArgs(
                                            modelId: _.lessons[index].id!,
                                            isCourse: false,
                                            isLesson: true));
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'الاختبارات',
                                          style: Get.textTheme.displayMedium!
                                              .copyWith(
                                                  color: kPrimary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color:
                                            Get.textTheme.displayMedium!.color!,
                                      ),
                                    ],
                                  ),
                                ).paddingSymmetric(horizontal: 20),
                                Container(
                                  height: 0.5,
                                  width: Get.width,
                                  color: Get.textTheme.displayMedium!.color!,
                                ).paddingSymmetric(
                                    vertical: 10, horizontal: 20),
                                Column(
                                  children: _.lessons[index].lectures
                                          ?.map((e) => InkWell(
                                                onTap: () async {
                                                  if (e.lectureType !=
                                                          Accessibility.free &&
                                                      !_
                                                          .isLoggedInWithSheet() &&
                                                      (Get.find<
                                                              HomeController>()
                                                          .isSecure)) {
                                                    return;
                                                  }
                                                  if ((e.lectureType !=
                                                          Accessibility.free &&
                                                      !(_.lessons[index]
                                                              .isEnrollemnt ??
                                                          false) &&
                                                      (Get.find<
                                                              HomeController>()
                                                          .isSecure))) {
                                                    _.showConfirmationDialog(
                                                        body:
                                                            'انت لست مشترك في هذا الكورس',
                                                        okCallback: () {
                                                          Get.bottomSheet(
                                                              SendRequest(
                                                                lessonId: _
                                                                        .lessons[
                                                                            index]
                                                                        .id ??
                                                                    0,
                                                                courseId: _
                                                                        .course
                                                                        .id ??
                                                                    0,
                                                              ),
                                                              elevation: 4,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              isDismissible:
                                                                  true);
                                                        },
                                                        lottie: AppLottie
                                                            .cancelOrder,
                                                        okText: 'إشتراك');
                                                    return;
                                                  }
                                                  Get.toNamed(
                                                      Routes.lecturesDetails,
                                                      arguments: e,
                                                      preventDuplicates: false);
                                                },
                                                child: Opacity(
                                                  opacity: 1,
                                                  child: Card(
                                                    color: !pref.darkTheme
                                                        ? kWhite
                                                        : kPrimary18,
                                                    shadowColor: pref.darkTheme
                                                        ? kWhite
                                                        : kBlack,
                                                    elevation: 2,
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: e
                                                                        .thumbImage ??
                                                                    _.course
                                                                        .image ??
                                                                    '',
                                                                height: 80,
                                                                width: 80,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            val) =>
                                                                        ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    AppImages
                                                                        .logoWhite,
                                                                    width: 80,
                                                                    height: 80,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if (!(_
                                                                        .lessons[
                                                                            index]
                                                                        .isEnrollemnt ??
                                                                    false) &&
                                                                e.lectureType !=
                                                                    Accessibility
                                                                        .free &&
                                                                (Get.find<
                                                                        HomeController>()
                                                                    .isSecure))
                                                              const Opacity(
                                                                opacity: 0.5,
                                                                child: SizedBox(
                                                                  height: 80,
                                                                  width: 80,
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .lock,
                                                                      color:
                                                                          kBlack,
                                                                      size: 30,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              e.title ?? '',
                                                              style: Get
                                                                  .textTheme
                                                                  .displayMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                            ).paddingOnly(
                                                                bottom: 10),
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .access_time_filled_rounded,
                                                                  color:
                                                                      kPrimary,
                                                                  size: 18,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  e.timing,
                                                                  style: Get
                                                                      .textTheme
                                                                      .displayMedium!
                                                                      .copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              kPrimary),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Stack(
                                                            children: [
                                                              RotatedBox(
                                                                quarterTurns:
                                                                    90,
                                                                child: Image.asset(
                                                                    AppImages
                                                                        .icPlay,
                                                                    width: 30,
                                                                    color:
                                                                        kPrimary,
                                                                    colorBlendMode:
                                                                        BlendMode
                                                                            .srcIn),
                                                              ),
                                                              if (!(_
                                                                          .lessons[
                                                                              index]
                                                                          .isEnrollemnt ??
                                                                      false) &&
                                                                  e.lectureType !=
                                                                      Accessibility
                                                                          .free &&
                                                                  (Get.find<
                                                                          HomeController>()
                                                                      .isSecure))
                                                                Transform
                                                                    .translate(
                                                                        offset: const Offset(
                                                                            -4,
                                                                            7),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .lock,
                                                                          color:
                                                                              kWhite,
                                                                          size:
                                                                              15,
                                                                        )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ).paddingOnly(bottom: 10),
                                                ),
                                              ))
                                          .toList() ??
                                      [],
                                ).paddingSymmetric(horizontal: 20),
                              ],
                            ),
                          ],
                        );
                      },
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      controller: _,
                      itemsCount: _.lessons.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
