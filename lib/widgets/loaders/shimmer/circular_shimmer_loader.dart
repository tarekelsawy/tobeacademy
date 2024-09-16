import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../theme/app_colors.dart';

class CircularShimmerLoader extends StatelessWidget {
  final Color baseColor;
  final int numOfItem;
  const CircularShimmerLoader({Key? key, this.baseColor= kPrimary, this.numOfItem = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SkeletonLoader(
            items: numOfItem,
            highlightColor: baseColor.withOpacity(0.18),
            builder: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                        Container(
                          width: 120,
                          height: 10,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 200,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        const SizedBox(height: 8),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: 100,
                                height: 6,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)))))
                      ]))
                ])))
      ],
    );
  }
}
