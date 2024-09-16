import 'dart:ffi';
import '../main.dart';

class AuthHelper {

  ///Data *********************************************************************
  bool isLoggedIn(){
    var client = pref.client;
    if(client == null) return false;
    return true;
  }

  ///Logout
  Future<Void?> logout() async {
    await pref.clear();
    return Future.value();
  }

}

/// USER TYPES ********************************
enum EUserRole { client, guest, other }

