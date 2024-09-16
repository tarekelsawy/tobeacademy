import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/courses/course_details/course_details_controller.dart';
import 'package:icourseapp/screens/courses/course_details/course_details_repository.dart';


class CourseDetailsBindings extends BaseBindings{
  @override
  void dependencies() {
    // Get.put(CourseDetailsRepository(), tag: tag);
    Get.put(CourseDetailsController(), tag: tag);
  }

}