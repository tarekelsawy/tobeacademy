import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidationUtil {

  static String? validateString(input, {int maxLength = 1000, int minLength = 3, FocusNode? node}) {
    if (input == null ||
        input.trim().length < minLength ||
        input.isEmpty ||
        input.length > maxLength) {
      if(node!= null ) {
        node.requestFocus();
        return 'invalid_entry'.tr;
      }else{
        return 'invalid_entry'.tr;
      }
    }

    return null;
  }


  static String? validateEmail(String? input,{FocusNode? node}) {
    if (ValidationUtil.isValidEmail(input)) return null;
    if(node!= null ) {
      node.requestFocus();
      return 'بريد الكتروني خاطئ';
    }else{
      return 'بريد الكتروني خاطئ';
    }
  }

  static String? validateWebsite(String? input){
    if(input == null || input.length <4) return 'invalid_entry'.tr;
    var isValidUrl = Uri.tryParse(input)?.hasScheme ?? false;
    if(isValidUrl) return null;
    return 'invalid_entry'.tr;
  }


  static String? validateNumber(input, {int minLength = 3}) {
    if (input == null ||
        input.trim().length < minLength ||
        input.isEmpty ||
        input.length > 20) return 'invalid_entry'.tr;
    if(!input.toString().isNumericOnly) return 'invalid_entry'.tr;
    if ((double.parse(input)) <= 0) return 'invalid_entry'.tr;
    return null;
  }

  static String? validatePhoneNumber(input) {
    if (input == null ||
        input.trim().isEmpty || (double.parse(input)) <= 0) return 'invalid_entry'.tr;
    if(input.length != 11) return 'يجب ان يتكون رقم الهاتف من 11 رقم';
      if (!(input.startsWith('01'))) return 'يجب ان يبدا رقم الهاتف ب 01';
    return null;
  }

  static String arabicNumber(String input){
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  static String? validatePassword(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'مطلوب';
    } else {
      if (value.length < 10) {
        return 'يجب أن يتكون من ١٠ احرف علي الاقل';
      }
      if (!regex.hasMatch(value)) {
        return 'يجب ان يحتوي علي احرف كبيره و صغيره وارقام ورموز';
      } else {
        return null;
      }
    }
  }

  static String? validateConfirmPassword(String? input, String password) {
    if (input?.compareTo(password) != 0) {
      return 'كلمه المرور غير مطابقه';
    }
    return null;
  }

  static bool isValidEmail(String? email) {
    if (email == null|| email.isEmpty) return false;
    return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(email);
  }

  static String? validateRating(int input) {
    if (input == 0) return 'choose_rate'.tr;
    return null;
  }
}
