import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../main.dart';
import '../../base/base_auth_controller.dart';
import '../../base/base_repository.dart';
import '../../models/user_guide.dart';
import '../../navigation/app_routes.dart';
import '../../theme/app_images.dart';

class UserGuideController extends BaseAuthController{

  @override
  BaseRepository? get repository => null;


  /// Data ************************************************
  final userGuides = <UserGuide> [
    const UserGuide(description: 'التعليم هو مفتاح النجاح والتقدم', image: AppImages.guide1),
    const UserGuide(description: 'كن مستعدًا لاكتشاف عوالم جديدة', image: AppImages.guide2),
    const UserGuide(description: 'فتح أبواب المعرفة والتطوير الشخصي', image: AppImages.guide3),
    const UserGuide(description: 'استعد لتحقيق أهدافك التعليمية', image: AppImages.guide4),
  ].obs;

  var currentPosition = 0.obs;

  final PageController pageController = PageController(keepPage: true);

  ///listener ******************************************************************
  onPageChange(int? value) {
   currentPosition.value = value??0;
  }

  onNavigateToLogin(){
    if(currentPosition.value < 3){
      pageController.animateToPage(currentPosition.value + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }else{
      pref.userGuide = true;
      if(pref.client == null){
        Get.offAllNamed(Routes.auth);
      }else {
        Get.offAllNamed(Routes.home);
      }
    }
  }

  onNavigateToCreateAccount(){
    pref.userGuide = true;
    Get.offAllNamed(Routes.register);
  }

}