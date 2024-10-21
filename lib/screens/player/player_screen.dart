import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/water_mark.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:custom_player/video_player/custom_video_player_view.dart';

import '../../db/app_pref.dart';

class PlayerWidget extends StatelessWidget {
  final String video;
  final double height;
  final String tag;
  final VideoType videoType;
  final bool isPlayerWithQuality;
  final Widget? secondPlayerWidget;
  const PlayerWidget({
    Key? key,
    required this.video,
    required this.height,
    required this.videoType,
    this.tag = 'youtube',
    required this.isPlayerWithQuality , required this.secondPlayerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pref = Get.put(AppPreferences());
    // var modernPlayerWidget = SizedBox(
    //   height: this.height,
    //   child: ModernPlayer.createPlayer(
    //     controlsOptions:ModernPlayerControlsOptions(
    //       showBackbutton: false
    //     ),
    //       video: ModernPlayerVideo.youtubeWithId(
    //           id: this.video, fetchQualities: true)),
    // );
    var modernPlayerWidget = isPlayerWithQuality
        ? SizedBox(
            height: height,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CustomVideoPlayer(
                youtubeId: video,
                name: pref.client?.name ?? '',
                phone: pref.client?.phone ?? '',
              ),
            ),
          )
        : secondPlayerWidget;
    log(video, name: "video");
    log(videoType.id, name: "id");
    log(videoType.name, name: "name");
    return GetBuilder<PlayerController>(
      init: PlayerController(),
      builder: (controller) => Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Container(
                //width: Get.width,
                //height: Get.height,
                color: pref.darkTheme ? kWhite : kBlack,
                child: modernPlayerWidget),

            //? For Wate Marking
            if (controller.isLoggedIn())
              Positioned.fill(
                  child:
                      IgnorePointer(ignoring: true, child: WaterMarkWidget())),
            if (controller.isLoggedIn())
              IgnorePointer(
                ignoring: true,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Text(
                          pref.client?.phone ?? '',
                          style: Get.textTheme.displayLarge!.copyWith(
                              color: kBlack.withOpacity(0.3),
                              fontSize: 18,
                              backgroundColor: kWhite.withOpacity(0.2)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/modern_player/src/modern_player.dart';
import 'package:icourseapp/modern_player/src/modern_player_options.dart';
import 'package:icourseapp/screens/player/full_screen_player_page.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/water_mark.dart';
import 'package:icourseapp/theme/app_colors.dart';

class PlayerWidget extends StatelessWidget {
  final String video;
  final String tag;
  final VideoType videoType;
  const PlayerWidget({
    Key? key,
    required this.video,
    required this.videoType,
    this.tag = 'youtube',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var modernPlayerWidget = ModernPlayer.createPlayer(
      options: ModernPlayerOptions(
        videoStartAt: 10
      ),
      controlsOptions: ModernPlayerControlsOptions(showBackbutton: false),
      video: ModernPlayerVideo.youtubeWithId(id: this.video, fetchQualities: true),
    );

    return GetBuilder<PlayerController>(
      init: PlayerController(),
      builder: (controller) => Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              color: pref.darkTheme ? kWhite : kBlack,
              child: modernPlayerWidget,
            ),
            // Watermark logic
            if (controller.isLoggedIn())
              Positioned.fill(child: WaterMarkWidget()),
            if (controller.isLoggedIn())
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Text(
                        pref.client?.phone ?? '',
                        style: Get.textTheme.displayLarge!.copyWith(
                          color: kBlack.withOpacity(0.3),
                          fontSize: 18,
                          backgroundColor: kWhite.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Fullscreen button
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.fullscreen, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullscreenPlayerPage(videoUrl: video),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/modern_player/src/modern_player.dart';
import 'package:icourseapp/modern_player/src/modern_player_options.dart';
import 'package:icourseapp/screens/player/full_screen_player_page.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/screens/player/water_mark.dart';
import 'package:icourseapp/theme/app_colors.dart';

class PlayerWidget extends StatelessWidget {
  final String video;
  final String tag;
  final VideoType videoType;
  const PlayerWidget({
    Key? key,
    required this.video,
    required this.videoType,
    this.tag = 'youtube',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var modernPlayerWidget = ModernPlayer.createPlayer(
      options: ModernPlayerOptions(
        videoStartAt: Get.find<PlayerController>().videoMinutes.value,
      ),
      controlsOptions: ModernPlayerControlsOptions(showBackbutton: false),
      video: ModernPlayerVideo.youtubeWithId(id: this.video, fetchQualities: true),
      // Add a listener to update the video position
      // This depends on how the library handles it. If it supports a callback for video position changes, use that.
    );

    return GetBuilder<PlayerController>(
      init: PlayerController(),
      builder: (controller) => Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              color: pref.darkTheme ? kWhite : kBlack,
              child: modernPlayerWidget,
            ),
            // Watermark logic
            if (controller.isLoggedIn())
              Positioned.fill(child: WaterMarkWidget()),
            if (controller.isLoggedIn())
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Text(
                        pref.client?.phone ?? '',
                        style: Get.textTheme.displayLarge!.copyWith(
                          color: kBlack.withOpacity(0.3),
                          fontSize: 18,
                          backgroundColor: kWhite.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Fullscreen button
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.fullscreen, color: Colors.white),
                onPressed: () async {
                  // Pass the current video position when navigating to fullscreen
                  final position = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullscreenPlayerPage(videoUrl: video, startAt: controller.videoMinutes.value),
                    ),
                  );
                  if (position != null) {
                    controller.videoMinutes.value = position;
                    controller.update(); // Update the controller to reflect changes
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
