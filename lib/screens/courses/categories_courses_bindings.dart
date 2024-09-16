import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/courses/categories_courses_controller.dart';
import 'package:icourseapp/screens/courses/categories_courses_repository.dart';

class CategoriesCoursesBindings extends BaseBindings{
  @override
  void dependencies() {
    // Get.put(CategoriesCoursesRepository());
    Get.put(CategoriesCoursesController(),tag: tag);
  }

}