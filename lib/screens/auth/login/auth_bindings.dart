import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/auth/login/auth_controller.dart';
import 'package:icourseapp/screens/auth/login/auth_repository.dart';



class AuthBindings extends BaseBindings{

  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(AuthController());
  }

}