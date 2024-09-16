import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/widgets/loaders/shimmer/border_grid_shimmer.dart';
import 'package:icourseapp/widgets/loaders/shimmer/border_raduis_card.dart';
import '../../../base/base_controller.dart';
import '../../../theme/app_colors.dart';
import 'chat_shimmer_loader.dart';
import 'circular_shimmer_loader.dart';
import 'grid_shimmer_loader.dart';
import 'linear_shimmer_loader.dart';

class ShimmerListLoader extends StatelessWidget {
  //Data
  final BaseController controller;
  final Widget child;
  final ShimmerLoaderType shimmerLoaderType;
  final Color baseColor;
  final double height, radius, horizontal, vertical;

  const ShimmerListLoader(
      {Key? key,
      required this.controller,
      required this.child,
      this.height = 80,
      this.radius = 15,
      this.horizontal = 15,
      this.vertical = 5,
      this.baseColor = kGrayCC,
      this.shimmerLoaderType = ShimmerLoaderType.borderRadius})
      : super(key: key);

  // Build **************************************
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value
        ? shimmerLoaderType == ShimmerLoaderType.chat
            ? ChatShimmerLoader(baseColor: baseColor)
            : shimmerLoaderType == ShimmerLoaderType.linearCircular
                ? CircularShimmerLoader(baseColor: baseColor)
                : shimmerLoaderType == ShimmerLoaderType.grid
                    ? const GridShimmerLoader()
                    : shimmerLoaderType == ShimmerLoaderType.borderRadius
                        ? BorderRadiusShimmerLoader(
                            height: height,
                            radius: radius,
                            baseColor: baseColor,
                            horizontal: horizontal,
                            vertical: vertical,
                          )
                        : shimmerLoaderType == ShimmerLoaderType.borderGrid
                            ? BorderGridShimmerLoader(
                                height: height,
                                radius: radius,
                                baseColor: baseColor,
                                horizontal: horizontal,
                                vertical: vertical,
                              )
                            : LinearShimmerLoader(baseColor: baseColor)
        : child);
  }
}

enum ShimmerLoaderType {
  linear,
  chat,
  linearCircular,
  grid,
  borderRadius,
  borderGrid
}
