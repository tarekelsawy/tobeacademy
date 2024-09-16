import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:upgrader/upgrader.dart';


class HomeScreen extends BaseView<HomeController> {
   HomeScreen({Key? key}) : super(key: key);
  @override
  final String? tag = null;

  @override
  PageAttributes get pageAttributes => PageAttributes(showAppBar: false,doLogout: true);

  @override
  Widget buildBody(BuildContext context) {
    return  Obx(() => controller.screens.toList()[controller.selectedIndex.value],);
  }



   @override
   Future<bool> onPopup() {
     return Future.value(false);
   }
}
