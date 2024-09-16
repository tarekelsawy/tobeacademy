import 'package:get/get.dart';
import 'package:icourseapp/screens/user_guide/user_guide_controller.dart';

import '../../base/base_bindings.dart';


class UserGuideBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(UserGuideController(),tag: tag);
  }

}