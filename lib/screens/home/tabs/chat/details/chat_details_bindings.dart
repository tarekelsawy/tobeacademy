import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/home/tabs/chat/details/chat_details_controller.dart';

import 'chat_details_repository.dart';

class ChatDetailsBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(ChatDetailsRepository());
    Get.put(ChatDetailsController(), tag: tag);
  }

}