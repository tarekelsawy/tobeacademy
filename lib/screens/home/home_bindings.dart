
import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/screens/home/home_repository.dart';


class HomeBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(HomeRepository());
    Get.put(HomeController());
  }

}