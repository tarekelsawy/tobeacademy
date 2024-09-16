import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../theme/app_colors.dart';

class LinearShimmerLoader extends StatelessWidget {
  final Color baseColor;

  const LinearShimmerLoader({Key? key, this.baseColor= kPrimary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SkeletonLoader(
          items: 8,
          highlightColor: baseColor.withOpacity(0.18),
          builder: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 12,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))))
                ]))
              ])))
    ]);
  }
}
