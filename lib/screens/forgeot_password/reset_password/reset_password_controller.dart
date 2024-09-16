import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_auth_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/forgeot_password/reset_password/reset_password_repository.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';



class ResetPasswordController extends BaseAuthController {
  @override
  ResetPasswordRepository get repository => Get.find();


  /// Data *************************************************
  String email = Get.arguments;
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  /// listeners ********************************************
  onLogin(){

   if(formKey.currentState!.validate()){
     _register();
   }
 }


  /// logic ************************************************
  _registerResponse(Resource resource){
   btnController.stop();
   if(resource.isError()) return;
   showSuccessMessage('تم اعاده تعيين كلمه المرور بنجاح');
   Get.offAllNamed(Routes.auth);
  }


 /// Api Requests ******************************************
 _register()async{
   var resource = await repository.newPassword(data: {
     "password": password.text,
     'password_confirmation': confirmPassword.text,
     'email': email
   });
   _registerResponse(resource);
 }



}

