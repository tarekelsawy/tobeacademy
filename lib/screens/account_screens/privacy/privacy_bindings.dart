import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_controller.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_repository.dart';
import 'package:icourseapp/screens/account_screens/privacy/privacy_controller.dart';
import 'package:icourseapp/screens/account_screens/privacy/privacy_repository.dart';

class PrivacyBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(PrivacyRepository(),tag: tag);
    Get.put(PrivacyController(),tag: tag);
  }

}