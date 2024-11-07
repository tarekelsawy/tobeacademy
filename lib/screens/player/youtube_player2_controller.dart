import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayer2Controller extends GetxController {
  final RxBool isPlaying = false.obs;
  final RxBool isFullScreen = false.obs;
  final String videoId;
  late YoutubePlayerController youtubePlayer2Controller;

  YoutubePlayer2Controller({required this.videoId});

  @override
  void onInit() {
    super.onInit();
    youtubePlayer2Controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        forceHD: true,
        hideControls: false,
        autoPlay: false,
        loop: false,
      ),
    );

    youtubePlayer2Controller.addListener(() {
      updateIsPlaying();
      updateIsFullScreen();
    });
  }

  // update is become full screen
  void updateIsFullScreen() {
    isFullScreen.value = youtubePlayer2Controller.value.isFullScreen;
  }

  void updateIsPlaying() {
    isPlaying.value = youtubePlayer2Controller.value.isPlaying;
  }

  // update is playing
  void togglePlayPause() {
    if (youtubePlayer2Controller.value.isPlaying) {
      youtubePlayer2Controller.pause();
      isPlaying.value = false;
    } else {
      youtubePlayer2Controller.play();
      isPlaying.value = true;
    }
  }

  void skip5sec() {
    youtubePlayer2Controller.seekTo(
      youtubePlayer2Controller.value.position + const Duration(seconds: 5),
    );
  }

  // Skip forward 10 seconds
  void skip10sec() {
    youtubePlayer2Controller.seekTo(
      youtubePlayer2Controller.value.position + const Duration(seconds: 10),
    );
  }

  // Rewind 10 seconds
  void previous10sec() {
    youtubePlayer2Controller.seekTo(
      youtubePlayer2Controller.value.position - const Duration(seconds: 10),
    );
  }

  // Rewind 5 seconds
  void previous5sec() {
    youtubePlayer2Controller.seekTo(
      youtubePlayer2Controller.value.position - const Duration(seconds: 5),
    );
  }
}
