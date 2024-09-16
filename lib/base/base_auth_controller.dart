import 'package:get/get.dart';
import 'package:icourseapp/helper/launch_flow.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import '../main.dart';
import 'base_controller.dart';

abstract class BaseAuthController extends BaseController {

  navigateTo() async {
    EFlowType flowType = await LaunchFlow.flow();
    switch (flowType) {
      case EFlowType.userGuides:
        // Get.offAllNamed(Routes.userGuide);
        break;
      case EFlowType.auth:
        Get.offAllNamed(Routes.auth);
        break;
      case EFlowType.home:
        Get.offAllNamed(Routes.home);
        break;
    }
  }


  /// Load and save to pref ****************************************************
  saveClient(User user) async {
    pref.client = user;
  }

}
