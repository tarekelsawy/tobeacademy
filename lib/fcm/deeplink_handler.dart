import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/models/chat_contacts.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import '../base/base_repository.dart';
import '../screens/home/home_repository.dart';
import '../screens/home/tabs/chat/chat_repository.dart';
import '../screens/splash/splash_controller.dart';


bool isFullScreenNotification = false;

class DeepLinkHandler extends BaseRepository {

  static void navigate(Map args) {
    Timer.periodic(const Duration(milliseconds: 700), (Timer t) async {
      if (Get.isRegistered<HomeController>()) {
        destination(args);
        t.cancel();
      }
    });
  }



  static destination(Map args) async {
    debugPrint("Inside deeplink destination ---------------> ${args.toString()}");
    if(!args.containsKey('type')) return;
    if(args['type'] == 'course') {
      Course? course = await _getCourse(args['model_id'].toString());
      if (course != null) {
        Get.toNamed(Routes.courseDetails, arguments: course);
      }
    }else if(args['type'] == 'message'){
      var contacts = await _getContacts();
      Get.toNamed(Routes.chatDetails, arguments: contacts.firstWhere((element) => element.id == args['model_id']));
    }
  }

  /// Nav **********************************************************************

  static Future<Course?> _getCourse(String courseId)async{
    var res = await HomeRepository().getCourse(courseId: courseId);
    if(res.isError()) return null;
    return res.data;
  }

  static Future<List<ChatContacts>> _getContacts()async{
    var res = await ChatRepository().getContacts();
    if(res.isError()) return [];
    return res.data;
  }
}
