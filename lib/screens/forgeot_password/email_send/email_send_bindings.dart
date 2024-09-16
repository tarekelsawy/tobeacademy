import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/forgeot_password/email_send/email_send_controller.dart';
import 'package:icourseapp/screens/forgeot_password/email_send/email_send_repository.dart';



class EmailSendBindings extends BaseBindings{

  @override
  void dependencies() {
    Get.put(EmailSendRepository());
    Get.put(EmailSendController());
  }

}