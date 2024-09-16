import 'package:get/get.dart';
import '../../local/localization_service.dart';
import '../../theme/app_themes.dart';

mixin LanguageMixin{

  /// data *********************************************************************
  late String currentLngCode = Get.locale?.languageCode ?? LocalizationService.fallbackLocale.languageCode;
  var languageChanged = false.obs;

  /// Helper Methods ***********************************************************
  onLanguageChanged(String lngCode) {
    currentLngCode = lngCode;
    languageChanged.value = currentLngCode != Get.locale?.languageCode;
    _submitChangeLanguage();
  }

  _submitChangeLanguage() async {
    if (!languageChanged.value) return;
    _updateLocaleLanguage();
  }

  _updateLocaleLanguage() {
    initFonts();
    LocalizationService().changeLocale(currentLngCode);
    Get.rootController.restartApp();
    languageChanged.value = false;
  }

}