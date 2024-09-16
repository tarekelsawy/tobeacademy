import 'package:get/get.dart';
import '../../base/base_bindings.dart';
import 'splash_controller.dart';

class SplashBindings extends BaseBindings {

  @override
  void dependencies() {
    Get.put(SplashController(), tag: tag);
  }

}