import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/base_theme_controllrt.dart';
import 'package:icourseapp/main.dart';

class AccountTabController extends BaseController{
  @override
  BaseRepository? get repository => null;

  @override
  onCreate() {
    isDark.value = pref.darkTheme;
  }

  /// Data ********************************************
  var isDark = false.obs;


  /// listeners ***************************************
  onSwitcherChange(bool? value){
    isDark.value = value??false;
    Get.find<BaseThemeController>().changeTheme();
    update();
  }





}