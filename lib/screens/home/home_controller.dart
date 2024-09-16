import 'dart:io';
import 'package:camera/camera.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:get_radio_version_plugin/get_radio_version_plugin.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/screens/home/bottom_nav_bar/bottom_bar_controller.dart';
import 'package:icourseapp/screens/home/home_repository.dart';
import 'package:icourseapp/screens/home/tabs/account_tab/account_tab_controller.dart';
import 'package:icourseapp/screens/home/tabs/account_tab/account_tab_screen.dart';
import 'package:icourseapp/screens/home/tabs/chat/chat_screen.dart';
import 'package:icourseapp/screens/home/tabs/home_tab/home_tab_screen.dart';
import 'package:icourseapp/screens/home/tabs/live_sessions/live_sessions_screen.dart';
import 'package:icourseapp/screens/home/tabs/my_courses/my_courses_screen.dart';
import 'package:icourseapp/screens/home/tabs/report/report_screen.dart';
import 'package:icourseapp/sheets/termas_condition/terms_condition.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:system_info2/system_info2.dart';
import '../../dio/dio_client.dart';
import '../../utils/api.dart';
import '../security_page.dart';

class HomeController extends BottomBarController {
  @override
  HomeRepository get repository => Get.find();

  @override
  onCreate() {
    _security();
    if (isLoggedIn()) {
      _sendFcm();
      getUser();
      getCounts();
    }
  }

  @override
  void onReady() {
    _preventScreenRecorder();
  }

  _preventScreenRecorder() async {
    if (isExit) {
      final isRecording = await ScreenProtector.isRecording();
      if (isRecording) {
        var platform = const MethodChannel('samples.secureapp');
        await platform.invokeMethod('makeSecure');
      }
    }
  }

  User? client;

  /// Data *********************************************************************
  List<Widget> screens = [
    ChatScreen(),
    HomeTabScreen(),
    LiveSessionsScreen(),
    ReportScreen(),
  ].obs;

  bool isSecure = false;
  bool isExit = false;

  var counts = 0.obs;
  var hasInterrupt = false.obs;

  @override
  selectIndex(int index) {
    super.selectIndex(index);

    if (isLoggedIn()) {
      getUser();
    }
  }

  _showTerms() {}

  /// Api requests ************************************************
  _sendFcm() async {
    await repository.sendFcm();
  }

  getUser() async {
    var resource = await repository.getUser();
    if (resource.isSuccess()) {
      client = resource.data;
      client?.token = pref.client?.token;
      pref.client = client;
      update();
      if (Get.isRegistered<AccountTabController>()) {
        Get.find<AccountTabController>().update();
      }
    }
  }

  _security() async {
    try {
      var response = await DioClient().dio.get(Api.securitySettings);
      var data = response.data;
      isSecure = data['no_subscribe'] != '1';
      if (isSecure) {
        items.value = [
          TabItem(
            icon: Icons.chat,
            title: 'chat'.tr,
          ),
          TabItem(
            icon: Icons.video_collection_outlined,
            title: 'my_courses'.tr,
          ),
          TabItem(
            icon: Icons.home_outlined,
            title: 'home'.tr,
          ),
          TabItem(
            icon: Icons.live_tv_rounded,
            title: 'live'.tr,
          ),
          const TabItem(
            icon: Icons.file_open_sharp,
            title: 'التقرير',
          )
        ];

        screens.insert(1, MyCoursesScreen());
        selectIndex(2);
        tabController = TabController(length: items.length, vsync: this);
        tabController!.index = 2;
      }
      if (data['key'] == '1') {
        isExit = true;

        if (Platform.isIOS) {
          ////111
          await ScreenProtector.preventScreenshotOn();
          bool jailbroken = await FlutterJailbreakDetection.jailbroken;
          if (jailbroken) {
            Get.offAll(() => SecurityPage());
            return;
          }
        } else if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

          if ((androidInfo.version.sdkInt) < 27) {
            Get.offAll(() => SecurityPage());
            return;
          }
          var memorySize = 0;
          try {
            memorySize = SysInfo.getFreeVirtualMemory();
          } catch (e) {}
          if (memorySize <= 0) {
            Get.offAll(() => SecurityPage());
            return;
          }
          // bool jailbroken = await FlutterJailbreakDetection.jailbroken;
          // if (jailbroken) {
          //   Get.offAll(() => SecurityPage());
          //   return;
          // }

          // bool developerMode = await FlutterJailbreakDetection.developerMode;
          // if (developerMode) {
          //   Get.offAll(() => SecurityPage());
          //   return;
          // }
          final info = await DeviceInfoPlugin().deviceInfo;
          print(info);
          if (Platform.isAndroid) {
            String? radioVersion;
            try {
              radioVersion = await GetRadioVersionPlugin.radioVersion ??
                  'Unknown radio version';
            } on PlatformException {
              radioVersion = 'Failed to get radio version.';
            }

            if (await EmulatorCheck.isEmulator(info, radioVersion) == true) {
              exit(0); // Get.offAll(() => SecurityPage());
            }
          }
          // Check for common files indicating an Android emulator
          List<String> emulatorFiles = [
            '/storage/emulated/0/storage/secure',
            '/storage/emulated/0/Android/data/com.android.ld.appstore',
          ];

          var isFileExist = true;
          for (String filePath in emulatorFiles) {
            if (File(filePath).existsSync()) {
              isFileExist = true;
            }
          }
          if (!isFileExist) {
            Get.offAll(() => SecurityPage());
            return;
          }

          await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
        } else {
          Get.offAll(() => SecurityPage());
        }
      } else {
        if (Platform.isAndroid) {
          await FlutterWindowManager.clearFlags(
              FlutterWindowManager.FLAG_SECURE);
        } else if (Platform.isIOS) {
          await ScreenProtector.preventScreenshotOff();
        }
      }
    } catch (e) {}

    _showTerms();
  }

  getCounts() async {
    var res = await repository.getContacts();
    if (res.isSuccess()) {
      counts.value = res.data;
    }
  }
}

class EmulatorCheck {
  static Future<bool> isEmulator(
      BaseDeviceInfo data, String? radioVersion) async {
    return data.data["fingerprint"].startsWith("generic") ||
        data.data["fingerprint"].startsWith("unknown") ||
        data.data["fingerprint"].contains("graceltexx") ||
        data.data["model"].contains("google_sdk") ||
        data.data["model"].contains("Emulator") ||
        data.data["model"].contains("Android SDK built for x86") ||
        data.data["manufacturer"].contains("Genymotion") ||
        data.data["model"].startsWith("sdk_") ||
        data.data["device"].startsWith("emulator") ||
        radioVersion == '1.0.0.0' ||
        radioVersion == '' ||
        radioVersion == null ||
        (data.data["brand"].startsWith("generic") &&
            data.data["device"].startsWith("generic")) ||
        "google_sdk" == data.data["product"] ||
        cameras.isEmpty ||
        cameras == null;
  }
}
