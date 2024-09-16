import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/screens/account_screens/contact_us/contact_us_repository.dart';

class ContactUsController extends BaseController {
  @override
  ContactUsRepository get repository => Get.find(tag: tag);

  /// Data *******************************************
  List<dynamic> contact = [];

  /// Api Request **************************************
  _getContacts() async {
    var resource = await repository.getContact();
    stopLoading();
    if (resource.isSuccess()) {
      contact = resource.data;
      update();
    }
  }

  @override
  onCreate() {
    loading.value = true;
    _getContacts();
  }
}
