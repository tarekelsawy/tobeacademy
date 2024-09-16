import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/quezzeis/quiz_details/quiz_details_controller.dart';
import 'package:icourseapp/screens/quezzeis/quiz_details/quiz_details_repository.dart';

class QuizBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(QuizDetailsRepository(),tag: tag);
    Get.put(QuizDetailsController(),tag: tag);
  }

}