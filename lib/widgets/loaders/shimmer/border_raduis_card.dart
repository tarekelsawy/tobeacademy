import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../theme/app_colors.dart';

class BorderRadiusShimmerLoader extends StatelessWidget {
  final Color baseColor;
  final double height, radius, horizontal, vertical;

  const BorderRadiusShimmerLoader(
      {Key? key,
      this.baseColor = kPrimary,
      required this.height,
      required this.radius,
      this.horizontal = 15,
      this.vertical = 5,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SkeletonLoader(
          items: 8,
          highlightColor: baseColor.withOpacity(0.18),
          builder: Container(
              padding:  EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
              child: Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(radius))),
                width: Get.width,
                height: height,
              )))
    ]);
  }
}
