import 'package:get/get.dart';
import 'package:icourseapp/base/base_bindings.dart';
import 'package:icourseapp/screens/organization/organizations_controller.dart';
import 'package:icourseapp/screens/organization/organizations_repository.dart';

class OrganizationsBindings extends BaseBindings{
  @override
  void dependencies() {
   Get.put(OrganizationsRepository(),tag: tag);
   Get.put(OrganizationsController(),tag: tag);
  }

}