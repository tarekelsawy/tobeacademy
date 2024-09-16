import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/files/files_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';
import 'package:icourseapp/widgets/loaders/shimmer/shimmer_list_loader.dart';
import 'package:icourseapp/widgets/pdf_viewer.dart';
import 'package:icourseapp/widgets/swipeable_list_view.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';
import '../../theme/app_images.dart';
import '../home/home_controller.dart';

class FileScreen extends BaseView<FileController> {
  FileScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(title: controller.course.title ?? '');

  var loading = false.obs;
  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<FileController>(
        init: controller,
        global: false,
        tag: tag,
        assignId: true,
        builder: (_) => ShimmerListLoader(
              controller: _,
              height: 60,
              radius: 20,
              horizontal: 20,
              child: SwipeableListView(
                itemBuilder: (context, index) {
                  return  Container(
                      decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 150,
                            child: Center(child: Image.asset(AppImages.pdfFile,height: 140,),),
                          ).paddingOnly(bottom: 15),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               if(_.files[index].downloadable)
                               Obx(
                                   ()=> loading.value? const Loader(size: LoaderSize.normal,color: kPrimary,): InkWell(
                                  onTap: () async{
                                    if(loading.value) return;
                                    Directory? downloadsDir;
                                    if(Platform.isIOS) {
                                      downloadsDir = await getDownloadsDirectory();
                                    }
                                    downloadsDir ??= await getApplicationDocumentsDirectory();

                                    loading.value = true;
                                    try {
                                      var response = await http.get(Uri.parse('https://www.dashboard.tobeacademy-mans.com/api/course/file/${_.files[index].id}/download'), headers: {
                                        'Accept': 'application/json',
                                        'Device-Id': deviceId,
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${pref.client?.token}'
                                      });
                                      print('URL -------> ${'https://www.dashboard.tobeacademy-mans.com/api/course/file/${_.files[index].id}/download'}');
                                      print('Body --------> ${response.body} - ${response.statusCode}');
                                      if (response.statusCode == 200) {
                                        File file = File('${downloadsDir.path}/${_.files[index].fileName}.pdf');
                                        await file.writeAsBytes(response.bodyBytes);
                                        HomeController().showSuccessMessage('تم حفظ الملف');
                                      } else {
                                        HomeController().showErrorMessage('فشل حفظ الملف');
                                      }
                                    } catch (e) {
                                      HomeController().showErrorMessage('فشل حفظ الملف');
                                    }

                                    loading.value = false;
                                  },
                                  child: const Icon(
                                    Icons.download,
                                    color: kPrimary,
                                    size: 40,
                                  ),
                          ).paddingOnly(bottom: 10),
                               ),
                               const SizedBox(width: 10,),
                               InkWell(
                                 onTap: () => Get.to(() => PdfViewer(
                                   lectureName: _.files[index].fileName,
                                   pdf: 'https://www.dashboard.tobeacademy-mans.com/api/course/file/${_.files[index].id}/preview',
                                   downloadUrl: 'https://www.dashboard.tobeacademy-mans.com/api/course/file/${_.files[index].id}/download',
                                 )),
                                 child: Icon(
                                   Icons.visibility,
                                   size: 35,
                                   color: Get.textTheme.displayLarge!.color!,
                                 ),
                               ),
                             ],
                           ),
                          Row(
                            children: [

                              Expanded(
                                  child: Text(
                                _.files[index].fileName,
                                style: Get.textTheme.displayLarge!
                                    .copyWith(fontSize: 16),
                              )),

                            ],
                          ).paddingSymmetric(horizontal: 20),
                        ],
                      ),
                    ).paddingOnly(bottom: 10).paddingSymmetric(horizontal: 10);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                controller: _,
                itemsCount: _.files.length,
              ),
            ));
  }
}
