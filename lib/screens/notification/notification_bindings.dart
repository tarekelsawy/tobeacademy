import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/notification/notification_controller.dart';
import 'package:icourseapp/screens/notification/notification_repository.dart';

class NotificationBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(NotificationController(),tag: tag);
  }

}