import 'package:get/get.dart';
import 'package:icourseapp/local/localization_service.dart';

class Language{

  String en,ar;

  Language({
    required this.en,
    required this.ar,
  });


  @override
  String toString() {
    return 'Language{en: $en, ar: $ar}';
  }

  String get value => LocalizationService.isRtl()? ar: en;

  factory Language.fromMap(dynamic map) {

    return Language(
      en: map['en'],
      ar: map['ar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}