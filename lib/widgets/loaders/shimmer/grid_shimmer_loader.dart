import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../theme/app_colors.dart';

class GridShimmerLoader extends StatelessWidget {
  final Color baseColor;

  const GridShimmerLoader({Key? key, this.baseColor = kPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: SingleChildScrollView(
          child: Center(child: Wrap(
            runSpacing:5,
            spacing:5,
            children: List.generate(15, (index) => skeleton()),
          ),)),
    );
  }

  Widget skeleton() {
    return SizedBox(width: Get.width/2.2,child: SkeletonLoader(
        items: 1,
        highlightColor: baseColor.withOpacity(0.18),
        builder: Container(
          width: Get.width/2.2,
          height: (Get.width/2.2),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
        )),);
  }
}
