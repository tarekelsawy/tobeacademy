import 'package:icourseapp/models/title_model.dart';

class Classes extends TitleModel{
  final String className;
  final String classKey;

  Classes({required this.className, required this.classKey});

  @override
  String get title => className;

}