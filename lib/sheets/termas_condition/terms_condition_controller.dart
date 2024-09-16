import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/general_model.dart';

import '../../screens/account_screens/privacy/privacy_repository.dart';

class TermsConditionController extends BaseController{
  @override
  BaseRepository? get repository => null;

  @override
  onCreate() {
    loading.value = true;
    _getBlogs();
  }

  /// Data ******************************************
  var privacy = <GeneralModel>[];

  /// Api Request ***********************************
  _getBlogs() async {
    var resource = await PrivacyRepository().getPrivacy();
    stopLoading();
    if (resource.isSuccess()) {
      privacy = resource.data;
      update();
    }
  }
}