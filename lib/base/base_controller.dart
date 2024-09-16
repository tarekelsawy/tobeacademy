import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/helper/auth_helper.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/theme/app_lottie.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import 'base_repository.dart';
import 'mixin_overlays.dart';

abstract class BaseController<R extends BaseRepository> extends GetxController with Overlays {
  /// Constructor ***********************************************
  final String tag = Get.currentRoute + kNumOfNav.toString();

  ///Data & Observables ******************************************
  var loading = false.obs;
  var isEmpty = false.obs;


  /// inject repo
  R? get repository;

  injectRepository() {}

  /// U need to inject a repo instance if not coming from a root , Bindings()

  // add all listeners to dispose them
  final List<StreamSubscription?> _disposableList = [];

  ///Matches on page creates
  @override
  void onInit() {
    injectRepository();
    onCreate();
    super.onInit();
  }

  ///Matches on page resume
  @override
  void onReady() {
    onResume();
    super.onReady();
  }


  @override
  void onClose() {
    onDestroy();
    super.onClose();
  }

  /// Messages
  showErrorMessage(String? msg) {
    show(msg!, kDanger);
  }

  showSuccessMessage(String msg) {
    show(msg, kGreen);
  }

  showMessage(String msg) {
    show(msg, kWarning);
  }

  show(String msg, Color color) {
    // Get.closeAllSnackbars();
    Get.snackbar('', '',
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        colorText: Colors.white,
        instantInit: false,
        titleText: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg,
              style: TextStyle(color: kWhite, fontFamily: kBold, fontSize: 16),
            ),
          ],
        ),
        snackPosition: SnackPosition.TOP);
  }

  showNotification(String title,String msg) {
    Get.closeAllSnackbars();
    Get.snackbar(title, msg,
        duration: const Duration(seconds: 2),
        backgroundColor: kGreen,
        colorText: Colors.white,
        instantInit: false,
        snackPosition: SnackPosition.TOP);
  }
  ///Abstract - instance  methods to do extra work after init
  onCreate() {}

  onResume() {}

  onDestroy() {}


  /// getters ******************************************************************

  ///Helper methods ************************************************************
  addDisposable(StreamSubscription subscription) =>
      _disposableList.add(subscription);


  stopLoading() {
    loading.value = false;
  }

  hideKeyboard() => FocusScope.of(Get.context!).requestFocus(FocusNode());

  String getLocaleFromEnums({required Map enumAttribute, required String key}){
    return enumAttribute[key]['label'][Get.locale!.languageCode];
  }

  // logout
  confirmLogout(){
    showConfirmationDialog(
        body: 'هل انت متاكد من انك تريد تسجيل الخروج؟',
        okCallback: () {
          doLogout();
        },
        lottie: AppLottie.logout,
        okText: 'تسجيل الخروج');
  }

  deleteAccount(){
    showConfirmationDialog(
        body: 'هل انت متاكد من انك تريد حذف الحساب؟',
        okCallback: () {
          doDeactivate();
        },
        lottie: AppLottie.trashBin,
        okText: 'حذف الحساب');
  }

  doLogout()async{
    await repository?.logout();
    await Get.find<AuthHelper>().logout();
    Get.offAllNamed(Routes.auth);
  }

  doDeactivate()async{
    await repository?.deActivate();
    await Get.find<AuthHelper>().logout();
    Get.offAllNamed(Routes.auth);
  }

  Future<void> launchWhatsApp(
      {required String phone}) async {
    var baseUrl =
    Platform.isIOS ? 'https://api.whatsapp.com/send?' : 'whatsapp://send?';
    var _url = "${baseUrl}phone=$phone";
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> launch(
      {required String url}) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  bool isLoggedIn()=>Get.find<AuthHelper>().isLoggedIn();

  bool isLoggedInWithSheet({String? title}){
    if(!isLoggedIn())  {
      showConfirmationDialog(
          body: 'يجب عليك تسجيل الدخول',
          okCallback: () {
            Get.toNamed(Routes.auth);
          },
          lottie: AppLottie.cancelOrder,
          okText: 'تسجيل الدخول');
      return false;
    }
    return true;
  }

  bool get isGuest => !Get.find<AuthHelper>().isLoggedIn();
  /// Checks ********************************************************************
  Future<bool> isPhoneVerified() async {

    return false;
  }

  bool isProfileCompleted(){
   return false;
  }

}
