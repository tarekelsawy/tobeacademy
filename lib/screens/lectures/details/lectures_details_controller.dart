import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_repository.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../main.dart';
import '../../../theme/app_colors.dart';

class LecturesDetailsController extends BaseController {
  @override
  LecturesDetailsRepository get repository => Get.find(tag: tag);

  @override
  onCreate() {
    if(!isLoggedIn()) return;
    if (lecture.type == LectureType.bunny) {
      loadLectures.value = true;
      _loadWebView();

    }
  }

  /*stopVideo() {
    if (Get.isRegistered<PlayerController>(tag: lecture.urlPath)) {
      Get.find<PlayerController>(tag: lecture.urlPath).videoController.pause();
    }
  }*/

  /// Data ********************************************
  Lecture lecture = Get.arguments;
  var loadLectures = false.obs;
  late WebViewController webViewController;

  /// logic ***********************************************
  _loadWebView() {
    print('-----> ${lecture.urlPath}');
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        pref.darkTheme ? kWhite : kBlack,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            loadLectures.value = false;
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            print('Error =====> ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )..clearCache()
      ..loadRequest(
          Uri.dataFromString(lecture.urlPath ?? '', mimeType: 'text/html'));
  }
  @override
  onDestroy() {
    // TODO: implement onDestroy
    Get.delete<PlayerController>();
    return super.onDestroy();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<PlayerController>();
    super.onClose();
  }
}
