import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class Bullet extends StatelessWidget{
  final double size;
  final Color bulletColor;
  final Color borderColorColor;

  const Bullet({Key? key, this.size=15,this.bulletColor = kPrimary, this.borderColorColor = kWhite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: size,height: size,decoration: BoxDecoration(color: bulletColor,border: Border.all(color: borderColorColor),shape: BoxShape.circle));
  }

}