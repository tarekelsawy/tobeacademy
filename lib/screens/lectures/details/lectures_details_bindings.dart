import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_controller.dart';
import 'package:icourseapp/screens/lectures/details/lectures_details_repository.dart';

class LecturesDetailsBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(LecturesDetailsRepository(),tag: tag);
    Get.put(LecturesDetailsController(),tag: tag);
  }

}