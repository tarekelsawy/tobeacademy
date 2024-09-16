import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../theme/app_colors.dart';

class ChatShimmerLoader extends StatelessWidget {
  final Color baseColor;
  const ChatShimmerLoader({Key? key, this.baseColor= kPrimary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        reverse: true,
        itemBuilder: (_, index) {
          if (index % 2 == 0) return chatMineSkeleton();
          return chatOtherSkeleton();
        });
  }

  Widget chatMineSkeleton() {
    return SkeletonLoader(
        items: 1,
        highlightColor: baseColor.withOpacity(0.18),
        builder: IntrinsicHeight(
            child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 5, left: 24, right: 4),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          constraints:
                              const BoxConstraints(minWidth: 120,maxWidth: 200, minHeight: 55),
                          decoration: const BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(0),
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25)),
                          )),
                    ]))));
  }

  Widget chatOtherSkeleton() {
    return SkeletonLoader(
        items: 1,
        highlightColor: baseColor.withOpacity(0.18),
        builder: Container(
            margin: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left:  0,
                right:  24 ),
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      constraints: const BoxConstraints(minWidth: 120,maxWidth: 180, minHeight: 50),
                      decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                      )),
                ])));
  }
}
