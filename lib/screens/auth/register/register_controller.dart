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
import 'package:icourseapp/screens/auth/register/register_repository.dart';
import 'package:icourseapp/screens/home/tabs/home_tab/home_tab_controller.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';

import '../../../models/classes.dart';
import '../../../sheets/termas_condition/terms_condition.dart';
import '../../../utils/image_util.dart';
import '../../home/home_controller.dart';


class RegisterController extends BaseAuthController {
  @override
  RegisterRepository get repository => Get.find();

  @override
  onCreate() {
    if(args?.action == DataAction.edit){
      email.text = pref.client?.email??'';
      phone.text = pref.client?.phone??'';
      address.text = pref.client?.address??'';
      firstName.text = pref.client!.name!.split(' ').isEmpty? '': pref.client?.name?.split(' ').first??'';
      lastName.text = pref.client!.name!.split(' ').length < 2? '': pref.client?.name?.split(' ').last??'';
    }
    if(args?.action == DataAction.socialLogin){
      email.text = args?.email??'';
      phone.text = args?.phone??'';
      firstName.text = (args!.name??'').split(' ').isEmpty? '': (args!.name??'').split(' ').first??'';
      lastName.text = (args!.name??'').split(' ').length < 2? '': (args!.name??'').split(' ').last??'';
    }
  }

  /// Data *************************************************
   var agree = false.obs;
  RegisterArgs? args = Get.arguments;
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<File?> image = Rx(null);
  dio.MultipartFile? file;
  Classes? classData;
  List<Classes> classes = [
    Classes(className: 'المرحله الثانويه', classKey: 'secondary'),
    Classes(className: 'المرحله الجامعيه', classKey: 'university'),
  ];
  
  

  /// listeners ********************************************
  User get user =>User(token: '', name: '', email: email.text, address: address.text.trim().isEmpty? null:address.text, phone: phone.text.trim().isEmpty?null:phone.text, firstName: firstName.text,lastName: lastName.text, avater: file, classes: classData?.classKey);
  onLogin(){
    if(args?.action != DataAction.edit){
      if(!agree.value){
        showErrorMessage('يجب الموافقه علي الشروط والاحكام');
        return;
      }

      if(user.classes == null){
        showErrorMessage('يجب اختيار المرحله التعليميه');
        return;
      }
    }

   if(formKey.currentState!.validate()){
     btnController.start();
     if(args != null && args?.action == DataAction.edit){
       _updateData();
       return;
     }

     if(args != null && args?.action == DataAction.socialLogin){
       _completeData();
       return;
     }
     _register(user);
   }
 }

  onShowTerms(){
    Get.bottomSheet(const TermsConditionSheet(),
        isDismissible: false, isScrollControlled: true, enableDrag: true);
  }

  onSelectClass(Classes? classes){
    classData = classes;
  }

  changeProfilePic() async {
    ImageUtil imageUtil = ImageUtil();
    var file = await imageUtil.pickImage();
    if (file == null || file.isEmpty) return;
    image.value = File(file.first.path!);
     this.file =  await dio.MultipartFile.fromFile(image.value!.path);
  }


  /// logic ************************************************
  _registerResponse(Resource resource){
   btnController.stop();
   if(resource.isError()) return;
   saveClient(resource.data);
   Get.offAllNamed(Routes.home);
  }

  _updateResponse(Resource resource){
    btnController.stop();
    if(resource.isError()) return;
    if(Get.isRegistered<HomeController>()){
      Get.find<HomeController>().getUser();
    }
    showSuccessMessage('تم تحديث البيانات بنجاح');
    Get.back();
  }
 /// Api Requests ******************************************
 _register(User user)async{
   var resource = await repository.studentRegister(data: user.toRegister(password: password.text));
   _registerResponse(resource);
 }


 Future<Map<String, dynamic>> _getData() async{
    if(image.value != null) {
      file = await dio.MultipartFile.fromFile(image.value!.path);
    }
    return {
      if(firstName.text.trim().isNotEmpty)
        'first_name': firstName.text,
      if(lastName.text.trim().isNotEmpty)
        'last_name': lastName.text,
      if(email.text.trim().isNotEmpty && pref.client?.email != email.text)
        'email': email.text,
      if(phone.text.trim().isNotEmpty && pref.client?.phone != phone.text)
        'phone_number': phone.text,
      if(classData != null)
        'class': classData?.classKey,

      if(address.text.trim().isNotEmpty)
        'address': address.text,
      if(file != null)
        'avatar': file,
      if(args?.provider != null)
        'provider': args?.provider,
      if(args?.providerId != null)
        'provider_id': args?.providerId
    };
 }

  _updateData()async{
    var data = await _getData();
    var resource = await repository.updateData(data: data, id: pref.client?.id?.toString()??'');
    _updateResponse(resource);
  }

  _completeData()async{
    var data = await _getData();
    var resource = await repository.completeData(data: data);
    _registerResponse(resource);
  }
}

enum DataAction {register, edit, socialLogin}