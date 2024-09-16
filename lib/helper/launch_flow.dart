import 'package:get/get.dart';
import 'package:icourseapp/helper/auth_helper.dart';
import 'package:icourseapp/main.dart';


class LaunchFlow {
  /// We add ignore email as user can skip this step ***
  static Future<EFlowType> flow() async {
    var authHelper = Get.find<AuthHelper>();
    // if(!pref.userGuide) return EFlowType.userGuides;
    if (!authHelper.isLoggedIn()) return EFlowType.auth;
    return EFlowType.home;
  }
}

enum EFlowType { userGuides, auth , home }
