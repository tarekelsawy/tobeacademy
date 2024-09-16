import 'args_phone.dart';

class ArgsAuth{
  final bool fromProfile;
  final PhoneInputMode? phoneInputMode;
  final String? codeFromLink;
  ArgsAuth({this.codeFromLink, this.fromProfile  = false,this.phoneInputMode});
}