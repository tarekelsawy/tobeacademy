import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/account_screens/contact_us/contact_us_controller.dart';
import 'package:icourseapp/screens/account_screens/contact_us/contact_us_repository.dart';

class ContactUsBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(ContactUsRepository(),tag: tag);
    Get.put(ContactUsController(),tag: tag);
  }

}