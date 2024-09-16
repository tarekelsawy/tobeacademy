import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/files/files_controller.dart';
import 'package:icourseapp/screens/files/files_repository.dart';

class FilesBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(FileRepository(),tag: tag);
    Get.put(FileController(),tag: tag);
  }

}