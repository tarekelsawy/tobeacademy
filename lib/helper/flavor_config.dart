import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../utils/paths.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  static Flavor? appFlavor;
  static Map<dynamic, dynamic>? config;

  static bool isDev() => appFlavor == Flavor.dev;

  ///Fetch config file depending on env
  static init() async {
    try {
      String jsonContent = await rootBundle.loadString(appFlavor == Flavor.prod
          ? "${jsonPath}config-prod.json"
          : "${jsonPath}config.json");
      config = json.decode(jsonContent);
    }catch(e){
      debugPrint(e.toString());
    }
  }


}
