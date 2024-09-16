import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../dio/dio_client.dart';
import '../main.dart';

class PdfViewer extends BaseView {
  final String lectureName, pdf, downloadUrl;
  PdfViewer(
      {Key? key,
      required this.lectureName,
      required this.pdf,
      required this.downloadUrl})
      : super(key: key);

  var loading = false.obs;
  @override
  PageAttributes get pageAttributes => PageAttributes(title: lectureName, showLine: false);

  @override
  Widget buildBody(BuildContext context) {
    return SizedBox(
        child: SfPdfViewer.network(
      pdf,
      headers: {
        'Device-Id': deviceId,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.client?.token}'
      },
    ));
  }

  // @override
  // List<Widget> buildAppbarActions() {
  //   return [
  //     Obx(
  //         ()=> IconButton(
  //           onPressed: () async {
  //             if(loading.value) return;
  //             Directory? downloadsDir;
  //             if(Platform.isIOS) {
  //               downloadsDir = await getDownloadsDirectory();
  //             }
  //             downloadsDir ??= await getApplicationDocumentsDirectory();
  //
  //             loading.value = true;
  //             try {
  //               var response = await http.get(Uri.parse(downloadUrl), headers: {
  //                 'Accept': 'application/json',
  //                 'Device-Id': deviceId,
  //                 'Content-Type': 'application/json',
  //                 'Authorization': 'Bearer ${pref.client?.token}'
  //               });
  //               print('--------> ${response.body}');
  //               if (response.statusCode == 200) {
  //                 File file = File('${downloadsDir.path}/${lectureName}.pdf');
  //                 await file.writeAsBytes(response.bodyBytes);
  //                 HomeController().showSuccessMessage('تم حفظ الملف');
  //               } else {
  //                 HomeController().showErrorMessage('فشل حفظ الملف');
  //               }
  //             } catch (e) {
  //               HomeController().showErrorMessage('فشل حفظ الملف');
  //             }
  //
  //             loading.value = false;
  //           },
  //           icon: loading.value? const Loader(): const Icon(
  //             Icons.download,
  //             color: kPrimary,
  //           )),
  //     ),
  //   ];
  // }
}
