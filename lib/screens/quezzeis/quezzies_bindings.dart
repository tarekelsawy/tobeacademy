import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/quezzeis/quezzies_controller.dart';
import 'package:icourseapp/screens/quezzeis/quezzies_repository.dart';

class QuezziesBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(QuezziesRepository(),tag: tag);
    Get.put(QuezziesController(),tag: tag);
  }

}