import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../theme/app_colors.dart';

class CardShimmerBorderedLoader extends StatelessWidget {
  final Color baseColor;
  final double height, width, radius;
  final double endPadding, bottomPadding;
  final Axis axis;
  final int numOfItems;
  const CardShimmerBorderedLoader(
      {Key? key,
      this.baseColor = kPrimary,
      required this.height,
      required this.width,
      required this.radius,
      this.numOfItems = 1,
      this.endPadding = 0,
      this.bottomPadding = 0,
      this.axis = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
        items: 1,
        highlightColor: baseColor.withOpacity(0.18),
        builder: Row(
            children: List.generate(numOfItems, (index) => Padding(
              padding: EdgeInsetsDirectional.only(
                  end: endPadding, bottom: bottomPadding),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius)),
              ),
            ),),
          ),
        );
  }
}
