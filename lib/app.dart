import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_theme_controllrt.dart';
import 'package:upgrader/upgrader.dart';
import 'di/initial_bindings.dart';
import 'helper/flavor_config.dart';
import 'local/localization_service.dart';
import 'navigation/app_pages.dart';
import 'theme/app_themes.dart';

int kNumOfNav = 0;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("ENVIRONMENT IS ${FlavorConfig.appFlavor.toString()}");
    return GetBuilder<BaseThemeController>(
      init: Get.find<BaseThemeController>(),
      builder: (controller) {
        return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // DefaultWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar')
            ],
            // title: LocalizationService.isRtl() ? 'تو بي اكاديمي' : 'To Be Academy',
            title:  'تو بي اكاديمي' ,
            theme: controller.currentTheme,
            locale: LocalizationService.getCurrentLocale(),
            fallbackLocale: LocalizationService.fallbackLocale,
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
            initialBinding: InitialBindings(),
            translations: LocalizationService(),
            routingCallback: (Routing? route) => route == null ||
                route.isBlank! ||
                route.isBottomSheet! ||
                route.isDialog!
                ? kNumOfNav
                : route.isBack!
                ? kNumOfNav--
                : kNumOfNav++,
          );
      }
    );
  }
}
