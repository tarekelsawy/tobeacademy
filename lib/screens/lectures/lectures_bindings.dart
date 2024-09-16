import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/lectures/lectures_controller.dart';
import 'package:icourseapp/screens/lectures/lectures_repository.dart';

class LecturesBindings extends BaseBindings{
  @override
  void dependencies() {
   Get.put(LecturesRepository(), tag: tag);
   Get.put(LecturesController(), tag: tag);
  }

}