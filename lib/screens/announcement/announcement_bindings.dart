import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/announcement/announcement_controller.dart';
import 'package:icourseapp/screens/announcement/announcement_repository.dart';


class AnnouncementBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(AnnouncementRepository(),tag: tag);
    Get.put(AnnouncementController(),tag: tag);
  }

}