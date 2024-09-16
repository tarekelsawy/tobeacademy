import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/general_model.dart';
import 'package:icourseapp/screens/account_screens/privacy/privacy_repository.dart';

class PrivacyController extends SwipeableController {
  @override
  PrivacyRepository get repository => Get.find(tag: tag);

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
    privacy.clear();
    _getBlogs();
  }

  /// Data ******************************************
  var privacy = <GeneralModel>[];

  /// Api Request ***********************************
  _getBlogs() async {
    var resource = await repository.getPrivacy();
    stopLoading();
    if (resource.isSuccess()) {
      privacy = resource.data;
      update();
    }
  }
}
