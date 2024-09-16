import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/forgeot_password/pin/phone_pin_repository.dart';

import '../../../../../base/base_controller.dart';
import '../../../../../widgets/buttons/loading_button.dart';


class PhonePinController extends BaseController {
  @override
  PhonePinRepository get repository => Get.find(tag: tag);

  /// Data *******************************************************
  TextEditingController pinController = TextEditingController();
  String email = Get.arguments;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();


  /// lifecycle methods  *****************************************

  /// Listeners ************************************************
  onVerify() {
    if(pinController.text.trim().isEmpty) return;
    _validateOtp();
  }


  /// Logic ******************************************************



  /// Api Requests **************************************************
  _validateOtp()async{
    btnController.start();
    var resource = await repository.validateOtp(data: {
      'email': email,
      'code': pinController.text
    });
    btnController.stop();
    if(resource.isSuccess()){
      Get.toNamed(Routes.resetPassword,arguments: email);
    }
  }
}

