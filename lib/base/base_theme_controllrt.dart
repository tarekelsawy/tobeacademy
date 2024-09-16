import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/theme/app_themes.dart';

class BaseThemeController extends BaseController {
  @override
  BaseRepository? get repository => null;

  @override
  onCreate() {
    isDarkTheme = pref.darkTheme;
    currentTheme = isDarkTheme ? AppThemes.dark : AppThemes.light;
    update();
  }

  /// Data *******************************************
  late ThemeData currentTheme;
  bool isDarkTheme = false;

  /// logic ******************************************
  changeTheme() async {
    isDarkTheme = !isDarkTheme;
    pref.darkTheme = isDarkTheme;
    currentTheme = isDarkTheme ? AppThemes.dark : AppThemes.light;
    Get.changeTheme(currentTheme);
    update();
  }
}
