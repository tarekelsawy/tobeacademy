import 'package:get/get.dart';
import 'package:icourseapp/dio/dio_client.dart';
import 'package:icourseapp/helper/auth_helper.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthHelper());
    Get.put(DioClient());
  }
}