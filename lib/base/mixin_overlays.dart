
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/dialogs/confirmation_dialog.dart';
import 'package:icourseapp/sheets/sheet_info.dart';

import '../sheets/must_login_sheet.dart';

mixin Overlays {
  showConfirmationDialog({required String body, required Function okCallback,Function? cancelCallback, String? cancelTxt, String? okText, double? minWidth, String?lottie, bool showCancel = true, num? score,num? standard, num? percentage, bool barrierDismissible = true}) {
    Get.dialog(ConfirmationDialog(
      text: body,
      cancelTxt: cancelTxt,
      minWidth: minWidth,
      lottie: lottie,
      okText: okText,
      score: score,
      standard: standard,
      percentage: percentage,
      showCancel: showCancel,
      onOkClick: () {
        Get.back();
        okCallback.call();
      },
      onCancelClick: () {
        Get.back();
        cancelCallback!.call();
      },), barrierDismissible: barrierDismissible);
  }


  showMustLoginSheet({String? title, Function? onOk, String? btnTitle}) {
    Get.bottomSheet(MustLoginSheet(title: title, btnTitle: btnTitle, onOk: onOk),
        elevation: 4,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: true);
  }

  showInfoSheet({String? title, Function? onOk, String? btnTitle}) {
    Get.bottomSheet(SheetInfo(title: title, btnTitle: btnTitle, onOk: onOk),
        elevation: 4,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: true);
  }
}
