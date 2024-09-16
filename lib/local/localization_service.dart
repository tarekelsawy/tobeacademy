import 'dart:ui';
import 'package:get/get.dart';
import 'package:icourseapp/local/en_us.dart';
import '../main.dart';
import 'ar_eg.dart';


class LocalizationService extends Translations {
  // Supported languages
  // Needs to be same order with locales
  static final lngsTitles = ['English', 'العربية'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [const Locale('en', 'US'), const Locale('ar', 'EG')];

  static String currentLocalCode() =>  "${getCurrentLocale()!.languageCode}_${getCurrentLocale()!.countryCode!}";

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = locales[indexOf(Get.deviceLocale?.languageCode)];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    'ar_EG': arEG // lang/ar_eg.dart
  };


  static int indexOf(String? code) => code == "ar" ? 1 : 0; // 1 ar local index , 0 En local index

  // Gets locale from language, and updates the locale
  void changeLocale(String langKey) {
    final locale = locales[indexOf(langKey)];
    pref.setCurrentLocale(langKey);
    Get.updateLocale(locale);
  }

  //get current local
  static Locale? getCurrentLocale() {
    if(pref.currentLocal() == null){
    // return locales[indexOf(Get.deviceLocale?.languageCode??'en')]  ;
    return locales[indexOf('ar')]  ;
    }
    return locales[indexOf(pref.currentLocal())];
  }

  ///check if RTL language **************************************************
  static bool isRtl({String? lngCode}) {
    if(lngCode!=null) {
      return _isCodeRtl(lngCode);
    }
    var deviceLocal = LocalizationService.locales[indexOf(Get.deviceLocale?.languageCode??'ar')];
    var local = Get.locale ?? getCurrentLocale() ?? deviceLocal;
    return _isCodeRtl(local.languageCode);
  }

  static bool _isCodeRtl(String lngCode){
    Iterable<String> iterable =
    rtlLanguages.where((element) => element == lngCode);
    return iterable.isNotEmpty;
  }
}
