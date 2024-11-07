import 'dart:io';
import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icourseapp/base/base_theme_controllrt.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:icourseapp/fcm/fcm_helper.dart';
import 'package:icourseapp/fcm/local_notifications_helper.dart';
import 'package:icourseapp/helper/flavor_config.dart';
import 'app.dart';
import 'db/app_pref.dart';
import 'package:get/get.dart';
import 'theme/app_themes.dart';
import 'package:package_info_plus/package_info_plus.dart';

List<CameraDescription> cameras = [];
FirebaseMessaging messaging = FirebaseMessaging.instance;
// FCM background callback
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

/// Global Vars ******************************
var pref = Get.put(AppPreferences());

String deviceId = '';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// Start Main ********************************
main() {
  FlavorConfig.appFlavor = Flavor.prod; //set flavor to prod
  initApp();
}

/// init app for both flavors
initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String packageName = packageInfo.packageName;
  if ((Platform.isAndroid && packageName == 'com.thezxras.toacademy') ||
      (Platform.isIOS && packageName == 'com.academy.tobeacademy')) {
// final config = TalsecConfig(
//     /// For Android
//     androidConfig: AndroidConfig(
//       packageName: 'com.zxra.beacademy',
//       signingCertHashes: [
//         'olg7XmR38IUmOUQXWSjrwnHPrsQ='
//       ],
//       // supportedStores: ['some.other.store'],
//     ),

//     /// For iOS
//     iosConfig: IOSConfig(
//       bundleIds: ['com.academy.tobeacademy'],
//       teamId: '5S3NK82PW3',
//     ),
//     watcherMail: 'ssayedaashrf@gmail.com',
//     // watcherMail: 's.eldin112@gmail.com',
//     isProd: false,
//   );
    // Setting up callbacks
//   final callback = ThreatCallback(
//       onAppIntegrity: () => exit(0),
//       onObfuscationIssues: () => exit(0),
//       onDebug: () => exit(0),
//       onDeviceBinding: () => exit(0),
//       onDeviceID: () =>exit(0),
//       onHooks: () =>exit(0),
//       onPasscode: () => exit(0),
//       onPrivilegedAccess: () => exit(0),
//       onSecureHardwareNotAvailable: () => exit(0),
//       onSimulator: () => exit(0),
//       onUnofficialStore: () => exit(0)
//   );
//  await Talsec.instance.start(config);

//   // Attaching listener
//   Talsec.instance.attachListener(callback);

    cameras = await availableCameras();
    HttpOverrides.global = MyHttpOverrides();
    await pref.init(); // init GetStorage.
    await Firebase.initializeApp();
    initFonts();

    /*SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);*/
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    /// init notification ********************************************************
    ///
    //! Re Remove
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    await initLocalNotifications(flutterLocalNotificationsPlugin);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMHelper().requestFCMIOSPermissions();
      //FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      FCMHelper().onMessageReceived();
      FCMHelper().initRemoteMessage();
      FCMHelper().onTokenChange();
    });

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = '${androidInfo.model}_${androidInfo.id}';
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = '${iosInfo.utsname.machine}_${iosInfo.model}';
    }

    Get.put(BaseThemeController());

    /// run app
    runApp(const App());
  } else {
    exit(0);
  }
}
