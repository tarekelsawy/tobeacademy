import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_controller.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_repository.dart';

class BlogsBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(BlogsRepository(),tag: tag);
    Get.put(BlogsController(),tag: tag);
  }

}