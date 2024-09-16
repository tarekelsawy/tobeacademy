/*import 'package:flutter/material.dart';
import 'package:icourseapp/modern_player/src/modern_player.dart';
import 'package:icourseapp/modern_player/src/modern_player_options.dart';

class FullscreenPlayerPage extends StatelessWidget {
  final String videoUrl;

  const FullscreenPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: ModernPlayer.createPlayer(
              video: ModernPlayerVideo.youtubeWithId(
                id: videoUrl, 
                fetchQualities: true,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.fullscreen_exit, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/modern_player/src/modern_player.dart';
import 'package:icourseapp/modern_player/src/modern_player_options.dart';
import 'package:icourseapp/screens/player/player_controller.dart';

class FullscreenPlayerPage extends StatelessWidget {
  final String videoUrl;
  final int startAt;

  const FullscreenPlayerPage({Key? key, required this.videoUrl, required this.startAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: ModernPlayer.createPlayer(
              options: ModernPlayerOptions(
                videoStartAt: startAt, // Use the start position here
              ),
              controlsOptions: ModernPlayerControlsOptions(showBackbutton: false),
              video: ModernPlayerVideo.youtubeWithId(id: videoUrl, fetchQualities: true),
              // Add a listener to update the video position
              // This depends on how the library handles it. If it supports a callback for video position changes, use that.
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.fullscreen_exit, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, Get.find<PlayerController>().videoMinutes.value);
              },
            ),
          ),
          // Display current video time
          Positioned(
            bottom: 10,
            left: 10,
            child: Obx(() => Text(
              '${Get.find<PlayerController>().videoMinutes.value}:${Get.find<PlayerController>().videoMinutes.value.toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
          ),
        ],
      ),
    );
  }
}*/
