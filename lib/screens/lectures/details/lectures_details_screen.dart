/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/quiz_args.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_controller.dart';
import 'package:icourseapp/screens/lectures/details/page_attributes_controller.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/player_screen.dart';
import 'package:icourseapp/theme/app_colors.dart';

class LecturesDetailsScreen extends BaseView<LecturesDetailsController> {
  LecturesDetailsScreen({Key? key}) : super(key: key);
  final PlayerController videoPlayerController = Get.put(PlayerController());

  @override
  PageAttributes get pageAttributes => PageAttributes(
        //title: controller.lecture.title,
        showAppBar: false,
        showNav: false,
      );

  @override
  Widget buildBody(BuildContext context) {
    final PlayerController playerController = Get.find();
    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        builder: (_) {
          return Obx(() => Scaffold(
              appBar: playerController.fullScreen.value
                  ? null
                  : AppBar(
                      centerTitle: true,
                      title: Text(controller.lecture.title ?? ""),
                    ),
              body: OrientationBuilder(
                builder: (context, orientation) {
                    bool isPortrait = orientation == Orientation.portrait;
                    playerController.fullScreen.value = !isPortrait;
                
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(() => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    playerController.fullScreen.value ? 0 : 20,
                                vertical:
                                    playerController.fullScreen.value ? 0 : 10),
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                Transform.rotate(
                                  angle: 0,
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(25),
                                    child: SizedBox(
                                      height: playerController.fullScreen.value
                                          ? Get.height
                                          : 230,
                                      width: Get.width,
                                      child: /*_.lecture.type == LectureType.bunny
                                  ? PlayerWidget(
                                      videoType: VideoType.bunny,
                                      video: _.lecture.urlPath!,
                                      tag: _.lecture.urlPath!,
                                    )
                                  : _.lecture.type == LectureType.video
                                      ? PlayerWidget(
                                          videoType: VideoType.normal,
                                          video: _.lecture.filePath!,
                                          tag: _.lecture.filePath!,
                                        )
                                      :*/
                                          //! Player Widget
                                          PlayerWidget(
                                          height:playerController.fullScreen.value
                                          ? Get.height
                                          : 230,
                                        videoType: VideoType.youtube,
                                        video: _.lecture.urlPath!,
                                        tag: _.lecture.urlPath!,
                                      ),
                                    ),
                                  ),
                                ),
                                !playerController.fullScreen.value
                                    ? const SizedBox(
                                        height: 20,
                                      )
                                    : const SizedBox(),
                                //!=======================
                                if (_.lecture.shortDescription != null)
                                  playerController.fullScreen.value
                                      ? Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: Text(
                                            'الوصف',
                                            style: Get.textTheme.displayMedium!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700),
                                          ))
                                      : SizedBox(),
                                if (_.lecture.shortDescription != null)
                                  playerController.fullScreen.value
                                      ? Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: Text(
                                            _.lecture.shortDescription ?? '',
                                            style: Get.textTheme.displayMedium!
                                                .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Get.textTheme
                                                        .displayMedium!.color!
                                                        .withOpacity(0.7)),
                                          ))
                                      : SizedBox(),
                                if (_.lecture.shortDescription != null)
                                  playerController.fullScreen.value
                                      ? Container(
                                          height: 0.5,
                                          width: Get.width,
                                          color:
                                              Get.textTheme.displayMedium!.color!,
                                        ).paddingSymmetric(vertical: 10)
                                      : SizedBox(),
                                //? Navigate to Quizes Page
                                !playerController.fullScreen.value
                                    ? InkWell(
                                        onTap: () {
                                          // _.stopVideo();
                                          Get.toNamed(Routes.quiz,
                                              arguments: QuizArgs(
                                                  modelId: _.lecture.id!,
                                                  isCourse: false));
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'الاختبارات',
                                                style: Get
                                                    .textTheme.displayMedium!
                                                    .copyWith(
                                                        color: kPrimary,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Get.textTheme.displayMedium!
                                                  .color!,
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            )),
                          )),
                    ),
                  ],
                ),}
              )));
        });
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/quiz_args.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_controller.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/player_screen.dart';
import 'package:icourseapp/theme/app_colors.dart';

class LecturesDetailsScreen extends BaseView<LecturesDetailsController> {
  LecturesDetailsScreen({Key? key}) : super(key: key);
  final PlayerController videoPlayerController = Get.put(PlayerController());

  @override
  PageAttributes get pageAttributes => PageAttributes(
        showAppBar: false,
        showNav: false,
      );

  @override
  Widget buildBody(BuildContext context) {
    final PlayerController playerController = Get.find();
    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        builder: (_) {
          return Obx(() => Scaffold(
              appBar: playerController.fullScreen.value
                  ? null
                  : AppBar(
                      centerTitle: true,
                      title: Text(controller.lecture.title ?? ""),
                    ),
              body: Column(
                children: [
                  Expanded(
                    child: Obx(() => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  playerController.fullScreen.value ? 0 : 20,
                              vertical:
                                  playerController.fullScreen.value ? 0 : 10),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Transform.rotate(
                                angle: 0,
                                child: ClipRRect(
                                  child: SizedBox(
                                    height: playerController.fullScreen.value
                                        ? Get.height
                                        : 230,
                                    width: Get.width,
                                    child: PlayerWidget(
                                      height: playerController.fullScreen.value
                                          ? Get.height
                                          : 230,
                                      videoType: VideoType.youtube,
                                      video: _.lecture.urlPath!,
                                      tag: _.lecture.urlPath!,
                                    ),
                                  ),
                                ),
                              ),
                              !playerController.fullScreen.value
                                  ? const SizedBox(height: 20)
                                  : const SizedBox(),
                              if (_.lecture.shortDescription != null &&
                                  playerController.fullScreen.value)
                                Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      'الوصف',
                                      style: Get.textTheme.displayMedium!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                    )),
                              if (_.lecture.shortDescription != null &&
                                  playerController.fullScreen.value)
                                Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      _.lecture.shortDescription ?? '',
                                      style: Get.textTheme.displayMedium!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Get.textTheme
                                                  .displayMedium!.color!
                                                  .withOpacity(0.7)),
                                    )),
                              if (_.lecture.shortDescription != null &&
                                  playerController.fullScreen.value)
                                Container(
                                        height: 0.5,
                                        width: Get.width,
                                        color:
                                            Get.textTheme.displayMedium!.color!)
                                    .paddingSymmetric(vertical: 10),
                              if (!playerController.fullScreen.value)
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.quiz,
                                        arguments: QuizArgs(
                                            modelId: _.lecture.id!,
                                            isCourse: false));
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
                                ),
                            ],
                          )),
                        )),
                  ),
                ],
              )));
        });
  }
}*/

//! 8:37 8/5/2024
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/quiz_args.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_controller.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/player_screen.dart';
import 'package:icourseapp/screens/player/water_mark.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/pod_package/pod_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../player/youtube_player2_controller.dart';

class LecturesDetailsScreen extends BaseView<LecturesDetailsController> {
  LecturesDetailsScreen({Key? key}) : super(key: key);
  final PlayerController videoPlayerController = Get.put(PlayerController());

  @override
  PageAttributes get pageAttributes => PageAttributes(
        showAppBar: false,
        showNav: false,
      );
  @override
  Widget buildBody(BuildContext context) {
    // final PlayerController playerController = Get.find();
    final YoutubePlayer2Controller videoPlayer2Controller =
        Get.put(YoutubePlayer2Controller(videoId: controller.lecture.urlPath!));

    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        builder: (_) {
          return Stack(
            children: [
              YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: videoPlayer2Controller.youtubePlayer2Controller,
                    aspectRatio: 230 / MediaQuery.of(context).size.width,
                    topActions: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            videoPlayer2Controller.skip10sec();
                          },
                          icon: const Icon(Icons.forward_10, color: kPrimary),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            videoPlayer2Controller.skip5sec();
                          },
                          icon: const Icon(Icons.forward_5, color: kPrimary),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            videoPlayer2Controller.previous5sec();
                          },
                          icon: const Icon(Icons.replay_5, color: kPrimary),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            videoPlayer2Controller.previous10sec();
                          },
                          icon: const Icon(Icons.replay_10, color: kPrimary),
                        ),
                      ),
                    ],
                  ),
                  builder: (BuildContext context, Widget player) {
                    return Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text(controller.lecture.title ?? ""),
                      ),
                      body: Column(
                        children: [
                          Obx(
                            () => SizedBox(
                              height: 230,
                              width: Get.width,
                              child: PlayerWidget(
                                height: 230,
                                secondPlayerWidget: player,
                                videoType: VideoType.youtube,
                                video: _.lecture.urlPath!,
                                tag: _.lecture.urlPath!,
                                isPlayerWithQuality: videoPlayerController
                                        .isFirstPlayerActive.value
                                    ? true
                                    : false,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.quiz,
                                    arguments: QuizArgs(
                                        modelId: _.lecture.id!,
                                        isCourse: false));
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
                                    color: Get.textTheme.displayMedium!.color!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  if (videoPlayerController
                                      .isFirstPlayerActive.value) {
                                    videoPlayerController.togglePlayer();
                                    videoPlayer2Controller
                                        .youtubePlayer2Controller
                                        .seekTo(const Duration(seconds: 0));
                                    videoPlayer2Controller
                                        .youtubePlayer2Controller
                                        .play();
                                  } else {
                                    videoPlayer2Controller
                                        .youtubePlayer2Controller
                                        .pause();
                                    videoPlayerController.togglePlayer();
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: videoPlayerController
                                                  .isFirstPlayerActive.value
                                              ? kPrimaryDark
                                              : kWhite,
                                          borderRadius:
                                              const BorderRadiusDirectional
                                                  .only(
                                            topStart: Radius.circular(10),
                                            bottomStart: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Player1',
                                            style: Get.textTheme.displayMedium!
                                                .copyWith(
                                                    color: videoPlayerController
                                                            .isFirstPlayerActive
                                                            .value
                                                        ? kWhite
                                                        : kPrimaryDark,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: videoPlayerController
                                                  .isFirstPlayerActive.value
                                              ? kWhite
                                              : kPrimaryDark,
                                          borderRadius:
                                              const BorderRadiusDirectional
                                                  .only(
                                            topEnd: Radius.circular(10),
                                            bottomEnd: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Player2',
                                            style: Get.textTheme.displayMedium!
                                                .copyWith(
                                                    color: videoPlayerController
                                                            .isFirstPlayerActive
                                                            .value
                                                        ? kPrimaryDark
                                                        : kWhite,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  }),
              if (controller.isLoggedIn() &&
                  videoPlayer2Controller
                      .youtubePlayer2Controller.value.isFullScreen)
                const Positioned.fill(
                    child: IgnorePointer(
                        ignoring: true, child: WaterMarkWidget())),
            ],
          );
        });
  }
}
/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/quiz_args.dart';
import 'package:icourseapp/modern_player/src/modern_player.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_controller.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/player_screen.dart';
import 'package:icourseapp/theme/app_colors.dart';

class LecturesDetailsScreen extends BaseView<LecturesDetailsController> {
  LecturesDetailsScreen({Key? key}) : super(key: key);
  final PlayerController videoPlayerController = Get.put(PlayerController());

  @override
  PageAttributes get pageAttributes => PageAttributes(
        showAppBar: false,
        showNav: false,
      );

  @override
  Widget buildBody(BuildContext context) {
    final PlayerController playerController = Get.find();
    return GetBuilder(
        init: controller,
        global: false,
        tag: tag,
        builder: (_) {
          return Obx(() => Scaffold(
              appBar: playerController.fullScreen.value
                  ? null
                  : AppBar(
                      centerTitle: true,
                      title: Text(controller.lecture.title ?? ""),
                    ),
              body: OrientationBuilder(
                builder: (context, orientation) {
                  bool isPortrait = orientation == Orientation.portrait;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (playerController.fullScreen.value != !isPortrait) {
                      playerController.fullScreen.value = !isPortrait;
                    }
                  });

                  return Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          try {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: playerController.fullScreen.value
                                      ? 0
                                      : 20,
                                  vertical: playerController.fullScreen.value
                                      ? 0
                                      : 10),
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Transform.rotate(
                                    angle: 0,
                                    child: ClipRRect(
                                      child: SizedBox(
                                        height:
                                            playerController.fullScreen.value
                                                ? Get.height
                                                : 230,
                                        width: Get.width,
                                        child: ModernPlayer(
                                          url: _.lecture.urlPath!,
                                          autoPlay: true,
                                          // Other configurations if needed
                                          onError: (error) {
                                            // Handle error
                                            print(
                                                "Error playing video: $error");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  !playerController.fullScreen.value
                                      ? const SizedBox(height: 20)
                                      : const SizedBox(),
                                  if (_.lecture.shortDescription != null &&
                                      playerController.fullScreen.value)
                                    Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Text(
                                          'الوصف',
                                          style: Get.textTheme.displayMedium!
                                              .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                        )),
                                  if (_.lecture.shortDescription != null &&
                                      playerController.fullScreen.value)
                                    Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Text(
                                          _.lecture.shortDescription ?? '',
                                          style: Get.textTheme.displayMedium!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Get.textTheme
                                                      .displayMedium!.color!
                                                      .withOpacity(0.7)),
                                        )),
                                  if (_.lecture.shortDescription != null &&
                                      playerController.fullScreen.value)
                                    Container(
                                            height: 0.5,
                                            width: Get.width,
                                            color: Get.textTheme.displayMedium!
                                                .color!)
                                        .paddingSymmetric(vertical: 10),
                                  if (!playerController.fullScreen.value)
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.quiz,
                                            arguments: QuizArgs(
                                                modelId: _.lecture.id!,
                                                isCourse: false));
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'الاختبارات',
                                              style: Get
                                                  .textTheme.displayMedium!
                                                  .copyWith(
                                                      color: kPrimary,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Get.textTheme.displayMedium!
                                                .color!,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              )),
                            );
                          } catch (error) {
                            print("Error initializing player: $error");
                            return Center(
                              child: Text(
                                  "An error occurred while playing the video."),
                            );
                          }
                        }),
                      ),
                    ],
                  );
                },
              )));
        });
  }
}*/
