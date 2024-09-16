import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_auth_controller.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/register_args.dart';
import 'package:icourseapp/models/user.dart';
import 'package:dio/dio.dart' as dio;
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/forgeot_password/email_send/email_send_repository.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';

import '../../../models/classes.dart';
import '../../../sheets/termas_condition/terms_condition.dart';
import '../../../utils/image_util.dart';


class EmailSendController extends BaseAuthController {
  @override
  EmailSendRepository get repository => Get.find();


  /// Data *************************************************
   var agree = false.obs;
  RegisterArgs? args = Get.arguments;
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  

  /// listeners ********************************************
  onLogin(){
   if(formKey.currentState!.validate()){
     btnController.start();
     _register();
   }
 }


  /// logic ************************************************
  _registerResponse(Resource resource){
   btnController.stop();
   if(resource.isError()) return;
   Get.toNamed(Routes.pin,arguments: email.text);
  }


 /// Api Requests ******************************************
 _register()async{
   var resource = await repository.forgotPassword(data: {
     "email": email.text
   });
   _registerResponse(resource);
 }
}
