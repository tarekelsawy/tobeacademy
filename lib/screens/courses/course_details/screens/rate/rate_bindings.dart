
import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/courses/course_details/screens/rate/rat_repository.dart';
import 'package:icourseapp/screens/courses/course_details/screens/rate/rate_controller.dart';

class RateBindings extends BaseBindings {
  @override
  void dependencies() {
    Get.put(RateRepository(), tag: tag);
    Get.put(RateController(), tag: tag);
  }
}
