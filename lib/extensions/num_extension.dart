import 'package:get/get.dart';

extension NumExtension on num{
  String get price => '${toStringAsFixed(2)} ${'ج.م'}';
}