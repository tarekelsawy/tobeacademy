import 'dart:io';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:image_pickers/image_pickers.dart';



class ImageUtil {
  static String resumes = "/resumes/";
  static String chatFile = "/chat/files/";
  static String chatImage = "/chat/images/";
  static String videos = "/input/";
  static String profiles = "/profiles/";
  static String schoolsLogo = "/schoolsLogo/";
  static String companies = "/companies/";
  static String companiesApplication = "/companies/applicationForm/";
  static String companiesProfile = "/companies/profiles/";
  static String attachment = "/attachment/";


  Future<List<Media>?> pickImage({bool isCover= false}) async {
    return await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      showCamera: true,
      selectCount: 1,
      cropConfig: isCover? CropConfig(width: 5,height: 2, enableCrop: true,): null,
      uiConfig:Platform.isIOS ? null : UIConfig(uiThemeColor: kPrimary),
      showGif: false,
    );
  }

  Future<List<Media>?> pickVideo() async {
    try{
      return await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.video,
        showCamera: true,
        selectCount: 1,
        uiConfig:Platform.isIOS ? null : UIConfig(uiThemeColor: kPrimary),
        showGif: false,
      );
    }catch (e, stackTrace) {
      debugPrint('ERROR Image Picker ${e.toString()}');
      return null;
    }

  }




  Future<File?> pickImageFile() async {
    List<Media>  _listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        uiConfig:Platform.isIOS ? null : UIConfig(uiThemeColor: kPrimary));
    File? file;
    if (_listImagePaths.isNotEmpty) {
      file = File(_listImagePaths.first.path!);
    }
    return file;
  }

  static viewImage(String? imgUrl) {
    // if(imgUrl == null) return;
    // Get.toNamed(Routes.imageViewer,arguments: imgUrl);
  }
}
