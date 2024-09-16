import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/general_model.dart';
import 'package:icourseapp/screens/account_screens/blogs/blogs_repository.dart';

class BlogsController extends SwipeableController {
  @override
  BlogsRepository get repository => Get.find(tag: tag);

  @override
  onCreate() {
    paginationEnabled(false);
    loading.value = true;
    _getBlogs();
  }

  @override
  loadMore() {}

  @override
  onRefresh() {
    blogs.clear();
    _getBlogs();
  }

  /// Data ******************************************
  var blogs = <GeneralModel>[];

  /// Api Request ***********************************
  _getBlogs() async {
    var resource = await repository.getBlogs();
    stopLoading();
    if (resource.isSuccess()) {
      blogs = resource.data;
      update();
    }
  }
}
