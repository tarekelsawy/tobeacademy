import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/account_screens/qrcode/qrcode_controller.dart';
import 'package:icourseapp/screens/account_screens/qrcode/qrcode_repository.dart';

class QRCodeBindings extends BaseBindings{
  @override
  void dependencies() {
    Get.put(QRCodeRepository(),tag: tag);
    Get.put(QRCodeController(),tag: tag);
  }

}