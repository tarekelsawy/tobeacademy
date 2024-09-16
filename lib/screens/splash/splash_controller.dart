import 'package:get/get.dart';
import 'package:icourseapp/base/base_auth_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/utils/app_util.dart';
// import 'package:no_screenshot/no_screenshot.dart';

bool splashLoaded = false;

class SplashController extends BaseAuthController
    with GetSingleTickerProviderStateMixin {
  @override
  BaseRepository? get repository => null;

  /// Data *********************************************************************
  var logoOpacity = 0.0.obs; //widget opacity observable
  Worker? _worker;


  @override
  onResume() {
  
    _startTimer();
    logoOpacity.value += 1;
  }


  @override
  onDestroy() {
    // Disposal of observables from a Controller are done automatically when the Controller is removed from memory
    //So no need to remove currentOpacity.obs subscribers ;) .
    _worker?.dispose();
  }

  /// Logic ********************************************************************

  //Wait 2 seconds then navigate to next page
  _startTimer() {
         

    //  AppUtil. noScreenshot.screenshotOff();
    _worker = debounce(logoOpacity, (_) => finishSplash(),
        time: const Duration(seconds: 3));
  }

  finishSplash() async {
    splashLoaded = true;
    if(!pref.userGuide){
      Get.offAllNamed(Routes.userGuide);
      return;
    }
    if(pref.client == null){
     Get.offAllNamed(Routes.auth);
    }else {
      Get.offAllNamed(Routes.home);
    }
  }



}
