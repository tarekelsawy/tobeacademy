import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../local/localization_service.dart';
class DateTimeUtil {
  static DateTime strYYYYMMMDDToDatetime(String yyyyMMdd) {
    return DateFormat("yyyy MMM dd", Get.locale?.languageCode ?? 'en').parse(yyyyMMdd);
  }
  static String toddMMYYYYFormat(DateTime dateTime) {
    return DateFormat("yyyy MMM dd",Get.locale?.languageCode ?? 'en').format(dateTime);
  }

  static String toYYYYFormat(DateTime dateTime) {
    return DateFormat("yyyy",Get.locale?.languageCode ?? 'en').format(dateTime);
  }
  static String toddMMMYYYYFormat(DateTime dateTime) {
    return DateFormat("dd MMM yyyy",Get.locale?.languageCode ?? 'en').format(dateTime);
  }
  static String toddMMYYYYHHMMFormat(DateTime dateTime) {
    return DateFormat("yyyy MMM dd, HH:mm").format(dateTime);
  }

  static String toddMMYYYYHHMMAFormat(DateTime dateTime) {
    return DateFormat("yyyy MMM dd, hh:mm a").format(dateTime);
  }
  static String toHHMMAMFormat(DateTime dateTime) {
    return DateFormat("hh:mm a", Get.locale?.languageCode ?? 'en').format(dateTime);
  }

  static String to24HHMMFormat(DateTime dateTime) {
    return DateFormat("hh : mm", Get.locale?.languageCode ?? 'en').format(dateTime);
  }
  static String toMeetingTime(DateTime dateTime) {
    return DateFormat("HH:mm DDD-MM-yyyy", Get.locale?.languageCode ?? 'en').format(dateTime);
  }
  static String parseTime(TimeOfDay time) {
    var hours = time.hour<10? '0${time.hour}' : time.hour.toString();
    var minutes = time.minute<10? '0${time.minute}' : time.minute.toString();
    return '$hours : $minutes';
  }

  ///Time Range ********************************************************************
  // static String getTimeRange(Timestamp timestamp) {
  //   var diff = Timestamp.now().toDate().difference(timestamp.toDate());
  //   if (diff.inSeconds <= 1) return 'now'.tr;
  //   if (diff.inSeconds <= 59) return _formatRangeInSeconds(diff);
  //
  //   if (diff.inMinutes <= 59) return _formatRangeInMinutes(diff);
  //
  //   if (diff.inHours < 24) return _formatRangeInHours(diff);
  //
  //   if (diff.inDays < 7) return _formatRangeInDays(diff);
  //
  //   return toddMMYYYYHHMMFormat(timestamp.toDate());
  // }

  static String _formatRangeInSeconds(Duration diff) {
    if (!LocalizationService.isRtl()) {
      if (diff.inSeconds == 1) {
        return "1 ${'second'.tr} ${'ago'.tr}";
      } else {
        return "${diff.inSeconds.toString()} ${'seconds'.tr} ${'ago'.tr}";
      }
    } else {
      if (diff.inSeconds == 1) {
        return "${'ago'.tr} ${'second'.tr}";
      } else if (diff.inSeconds == 2) {
        return "${'ago'.tr} ${'two_seconds'.tr}";
      } else if (diff.inSeconds <= 10) {
        return "${'ago'.tr} ${diff.inSeconds.toString()} ${'seconds'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inSeconds.toString()} ${'second'.tr}";
      }
    }
  }

  static String _formatRangeInMinutes(Duration diff) {
    if (!LocalizationService.isRtl()) {
      if (diff.inMinutes == 1) {
        return "1 ${'minute'.tr} ${'ago'.tr}";
      } else {
        return "${diff.inMinutes.toString()} ${'minutes'.tr} ${'ago'.tr}";
      }
    } else {
      if (diff.inMinutes == 1) {
        return "${'ago'.tr} ${'minute'.tr}";
      } else if (diff.inMinutes == 2) {
        return "${'ago'.tr} ${'two_minutes'.tr}";
      } else if (diff.inMinutes <= 10) {
        return "${'ago'.tr} ${diff.inMinutes.toString()} ${'minutes'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inMinutes.toString()} ${'minute'.tr}";
      }
    }
  }

  static String _formatRangeInHours(Duration diff) {
    if (!LocalizationService.isRtl()) {
      if (diff.inHours == 1) {
        return "1 ${'hour'.tr} ${'ago'.tr}";
      } else {
        return "${diff.inHours.toString()} ${'hours'.tr} ${'ago'.tr}";
      }
    } else {
      if (diff.inHours == 1) {
        return "${'ago'.tr} ${'hour'.tr}";
      } else if (diff.inHours == 2) {
        return "${'ago'.tr} ${'two_hours'.tr}";
      } else if (diff.inHours <= 10) {
        return "${'ago'.tr} ${diff.inHours.toString()} ${'hours'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inHours.toString()} ${'hour'.tr}";
      }
    }
  }

  static String _formatRangeInDays(Duration diff) {
    if (diff.inDays == 1) return 'yesterday'.tr;
    if (!LocalizationService.isRtl()) {
      return "${diff.inDays.toString()} ${'days'.tr} ${'ago'.tr}";
    } else {
      if (diff.inDays == 2) {
        return "${'ago'.tr} ${'two_days'.tr}";
      } else if (diff.inDays <= 10) {
        return "${'ago'.tr} ${diff.inDays.toString()} ${'days'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inDays.toString()} ${'day_'.tr}";
      }
    }
  }
}