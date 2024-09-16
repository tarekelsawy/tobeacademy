import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/screens/account_screens/qrcode/qrcode_repository.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeController extends BaseController{
  @override
  QRCodeRepository get repository => Get.find(tag: tag);

  /// Data *****************************************************
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  StreamSubscription? subscription;


  /// listeners *****************************************************
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    subscription =   controller.scannedDataStream.listen((scanData) {
      _sendCode(code: '${scanData.code}');
    });
  }

  @override
  onDestroy() {
    controller?.dispose();
  }

  _sendCode({required String code})async{
    subscription?.cancel();
    var res = await repository.sendCode(code: code);
    Get.back();
    if(res.isSuccess()){
      showSuccessMessage('تم تسجيل الحضور بنجاح');
    }else{
      showErrorMessage('خطأ اثناء تسجيل الحضور');
    }
  }

}