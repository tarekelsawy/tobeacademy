import 'dart:io';

import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/file_model.dart';
import 'package:icourseapp/screens/files/files_repository.dart';

class FileController extends SwipeableController {
  @override
  FileRepository get repository => Get.find(tag: tag);

  @override
  onCreate() {
    paginationEnabled(false);
    loading.value = true;
    _getFiles();
  }
  /// Data **********************************************
  var files = <FileModelData>[];
  Course course = Get.arguments;

  /// logic *********************************************
  _responseFiles(Resource resource) {
    stopLoading();
    if(resource.isError()) return;
    files = resource.data;
    update();
  }

  /// Api Requests **************************************
  _getFiles() async {
    var resource = await repository.getFiles(id: course.id!);
    _responseFiles(resource);
  }

  @override
  loadMore() {
  }

  @override
  onRefresh() {
    files.clear();
    _getFiles();
  }
}
