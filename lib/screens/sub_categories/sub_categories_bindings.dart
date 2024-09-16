import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/sub_categories/sub_categories_controller.dart';
import 'package:icourseapp/screens/sub_categories/sub_categories_repository.dart';

class SubCategoriesBindings extends BaseBindings{
  @override
  void dependencies() {
   Get.put(SubCategoriesRepository(),tag: tag);
   Get.put(SubCategoriesController(),tag: tag);
  }

}