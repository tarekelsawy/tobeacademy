import 'dart:io';

import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/announcement.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/file_model.dart';
import 'package:icourseapp/screens/announcement/announcement_repository.dart';
import 'package:icourseapp/screens/files/files_repository.dart';

class AnnouncementController extends SwipeableController {
  @override
  AnnouncementRepository get repository => Get.find(tag: tag);

  @override
  onCreate() {
    paginationEnabled(false);
    loading.value = true;
    _getFiles();
  }
  /// Data **********************************************
  var announcements = <Announcement>[];
  Course course = Get.arguments;

  /// logic *********************************************
  _responseFiles(Resource resource) {
    stopLoading();
    if(resource.isError()) return;
    announcements = resource.data;
    update();
  }

  /// Api Requests **************************************
  _getFiles() async {
    var resource = await repository.getAnnouncement(id: course.id!);
    _responseFiles(resource);
  }

  @override
  loadMore() {
  }

  @override
  onRefresh() {
    announcements.clear();
    _getFiles();
  }
}
