import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/forgeot_password/reset_password/reset_password_controller.dart';
import 'package:icourseapp/screens/forgeot_password/reset_password/reset_password_repository.dart';



class ResetPasswordBindings extends BaseBindings{

  @override
  void dependencies() {
    Get.put(ResetPasswordRepository());
    Get.put(ResetPasswordController());
  }

}