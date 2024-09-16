import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/categories/categories_controller.dart';
import 'package:icourseapp/screens/categories/categories_repository.dart';

class CategoriesBindings extends BaseBindings{
  @override
  void dependencies() {
   Get.put(CategoriesRepository(),tag: tag);
   Get.put(CategoriesController(),tag: tag);
  }

}