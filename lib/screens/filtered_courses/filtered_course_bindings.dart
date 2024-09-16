import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/filtered_courses/filtered_course_controller.dart';
import 'package:icourseapp/screens/filtered_courses/filtered_course_repository.dart';

class FilteredCourseBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(FilteredCourseRepository(),tag: tag);
    Get.put(FilteredCourseController(),tag: tag);
  }

}