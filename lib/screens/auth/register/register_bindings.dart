import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/auth/register/register_controller.dart';
import 'package:icourseapp/screens/auth/register/register_repository.dart';



class RegisterBindings extends BaseBindings{

  @override
  void dependencies() {
    Get.put(RegisterRepository());
    Get.put(RegisterController());
  }

}