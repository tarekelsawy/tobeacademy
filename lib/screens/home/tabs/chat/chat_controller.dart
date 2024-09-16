import 'dart:convert';

import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/pusher_mixin.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/chat_contacts.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/tabs/courses/courses_repository.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../main.dart';
import 'chat_repository.dart';

class ChatController extends SwipeableController{
  @override
  injectRepository() {
    Get.put(ChatRepository());
  }

  @override
  onDestroy() {
    Get.delete<ChatRepository>();
  }

  @override
  onCreate() {
    if(!isLoggedIn()) return;
    loading.value = true;
    _getContacts();
  }

  @override
  loadMore() {
    stopLoading();
  }

  @override
  onRefresh() {
    stopLoading();
  }

  @override
  ChatRepository get repository => Get.find();


  /// listeners *******************************************


  /// Data *************************************************
  var contacts = <ChatContacts>[];

  /// logic ***************************************

  onNavigateTo(ChatContacts contacts)async{
    await  Get.toNamed(Routes.chatDetails,
        arguments: contacts);
    _getContacts();
  }

  updateContacts(){
    _getContacts();
  }

  /// Api Requests ***************************************
  _getContacts()async{
    var resource = await repository.getContacts();
    loading.value = false;
    if(resource.isSuccess()){
      contacts = resource.data;
      update();
    }
  }




}
