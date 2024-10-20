import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/screens/player/video_player_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerController extends BaseController {
  @override
  VideoPlayerRepository get repository => Get.put(VideoPlayerRepository());

  /// Data *********************************************************************

  Random random = Random();
  var positionX = 0.0.obs;
  var positionY = 0.0.obs;
  var showAnimation = false.obs;
  var getVideoResolution = false.obs;
  var showNavigation = false.obs;

  Rx<bool> fullScreen = false.obs;

  Timer? timer;

  void startAnimation() async {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      positionX.value = random.nextDouble() * (Get.width - 50);
      positionY.value = random.nextDouble() * 100;
    });
  }

  @override
  onDestroy() {
    Get.delete<VideoPlayerRepository>();
    timer?.cancel();
  }

  Future<List<num>> _getVideoResolution({required String videoId}) async {
    var resource = await repository.getVideoResolution(videoId: videoId);
    if (resource.isSuccess()) {
      return resource.data;
    } else {
      return <num>[480];
    }
  }
}
/*import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/screens/player/video_player_repository.dart';

class PlayerController extends BaseController {
  @override
  VideoPlayerRepository get repository => Get.put(VideoPlayerRepository());

  /// Data *********************************************************************
  Random random = Random();
  var positionX = 0.0.obs;
  var positionY = 0.0.obs;
  var showAnimation = false.obs;
  var getVideoResolution = false.obs;
  var showNavigation = false.obs;

  Rx<int> videoMinutes = 0.obs;

  Timer? timer;

  void startAnimation() async {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      positionX.value = random.nextDouble() * (Get.width - 50);
      positionY.value = random.nextDouble() * 100;
    });
  }


  @override
  void onDestroy() {
    Get.delete<VideoPlayerRepository>();
    timer?.cancel();
  }

  Future<List<num>> _getVideoResolution({required String videoId}) async {
    var resource = await repository.getVideoResolution(videoId: videoId);
    if (resource.isSuccess()) {
      return resource.data;
    } else {
      return <num>[480];
    }
  }
}*/
