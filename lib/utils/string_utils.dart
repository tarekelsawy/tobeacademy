import 'package:get/get.dart';
//import 'package:short_uuids/short_uuids.dart';
import 'package:uuid/uuid.dart';


class StringUtils {
  static final Uuid _uuid = Uuid();
  static String get randomTag => _uuid.v4().substring(0, 8);
  //static String get randomTag => const ShortUuid().generate();

  static String timeFromSeconds(int totalSeconds){
    int seconds = totalSeconds % 60;
    int minutes = totalSeconds~/60;
    String secondsStr = seconds>9? seconds.toString() : '0$seconds';
    String minutesStr = minutes>9? minutes.toString() : '0$minutes';
    return '$minutesStr : $secondsStr';
  }

  static String duration(Duration? duration, {bool withChars = false}){
    if(duration == null) return '';
    var secondsStr = (duration.inSeconds%60).toString();
    var minutesStr =duration.inMinutes == 60 ? duration.inMinutes.toString() : (duration.inMinutes%60).toString();
    if(secondsStr.length==1) secondsStr = '0$secondsStr';
    if(minutesStr.length==1) minutesStr = '0$minutesStr';
    if(withChars) return'$minutesStr ${'m'.tr} $secondsStr ${'s'.tr}';
    return '$minutesStr:$secondsStr';
  }
}