import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/account_screens/qrcode/qrcode_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends BaseView<QRCodeController> {
   QRCodeScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(showNav: false,transparentAppBar: true,title: '', showLine: false);


  @override
  Widget buildBody(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: kBlack,
      child: QRView(
        key: controller.qrKey,
        onQRViewCreated: controller.onQRViewCreated,
      ),
    );
  }
}
