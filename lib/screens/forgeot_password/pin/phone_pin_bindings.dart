import 'package:get/get.dart';
import 'package:icourseapp/screens/forgeot_password/pin/phone_pin_controller.dart';
import 'package:icourseapp/screens/forgeot_password/pin/phone_pin_repository.dart';

import '../../../../../base/base_bindings.dart';


class PhonePinBindings extends BaseBindings {

  @override
  void dependencies() {
    Get.put(PhonePinRepository(), tag: tag);
    Get.put(PhonePinController(), tag: tag);
  }
}
