import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icourseapp/models/user.dart';


///Storage Keys
enum PreferenceKeys { keyAppLocal, keyHasClientClaims, keyUserGuide, keyClient, keyTheme, keyTermsCondition }

class AppPreferences {
  //Data
  late GetStorage _storage;

  //init
  init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  ///Client data *************************************************
  set client(User? client) {
    debugPrint('Data Pref -------------- ${client!.toMap().toString()}');
    String user = jsonEncode(client.toMap());
    _storage.write(PreferenceKeys.keyClient.toString(), user);
  }

  User? get client {
    String clientStr = _storage.read(PreferenceKeys.keyClient.toString()) ?? "";

    if (clientStr.isEmpty) return null;
    // print('String ----------> ${json.decode(clientStr)}');
    return User.fromMap(json.decode(clientStr));
  }

  ///App Locale ****************************************************************
  String? currentLocal() {
    return _storage.read(PreferenceKeys.keyAppLocal.toString()); // Language
  }

  setCurrentLocale(String? language) {
    _storage.write(PreferenceKeys.keyAppLocal.toString(), language);
  }

  ///User Guide ****************************************************************
  set userGuide(bool taken) {
    _storage.write(PreferenceKeys.keyUserGuide.toString(), taken);
  }

  bool get userGuide =>
      _storage.read(PreferenceKeys.keyUserGuide.toString()) ?? false;

  ///User Guide ****************************************************************
  set darkTheme(bool taken) {
    _storage.write(PreferenceKeys.keyTheme.toString(), taken);
  }

  bool get darkTheme =>
      _storage.read(PreferenceKeys.keyTheme.toString()) ?? false;

  ///Terms Condition ****************************************************************
  set terms(bool taken) {
    _storage.write(PreferenceKeys.keyTermsCondition.toString(), taken);
  }

  bool get terms =>
      _storage.read(PreferenceKeys.keyTermsCondition.toString()) ?? false;

  ///Has client claims *******************************************
  setHasClientClaims(bool taken) {
    _storage.write(PreferenceKeys.keyHasClientClaims.toString(), taken);
  }

  bool hasClientClaims() {
    return _storage.read(PreferenceKeys.keyHasClientClaims.toString()) ?? false;
  }

  ///Clear *********************************************************************
  clear() async {
    String? local = currentLocal();
    bool guide = userGuide;
    bool themeData = darkTheme;
    await _storage.erase();
    setCurrentLocale(local);
    userGuide = guide;
    darkTheme = themeData;
  }
}
