import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:icourseapp/main.dart';

import '../../db/app_pref.dart';
import '../../theme/app_colors.dart';

class WaterMarkWidget extends StatefulWidget {
  const WaterMarkWidget({super.key});

  @override
  State<WaterMarkWidget> createState() => _WaterMarkWidgetState();
}

class _WaterMarkWidgetState extends State<WaterMarkWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _animation;

  List<int> nums = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int selectdPosition = 1;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(seconds: 15),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reset();
        _animationController.forward();
        selectdPosition == 9 ? selectdPosition = 1 : selectdPosition += 1;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    // timer.cancel();
    super.dispose();
  }

  Alignment movement() {
    switch (selectdPosition) {
      case 1:
        return Alignment.topLeft;
      case 2:
        return Alignment.topCenter;
      case 3:
        return Alignment.topRight;
      case 4:
        return Alignment.centerLeft;
      case 5:
        return Alignment.center;
      case 6:
        return Alignment.centerRight;
      case 7:
        return Alignment.bottomLeft;
      case 8:
        return Alignment.bottomCenter;
      case 9:
        return Alignment.bottomRight;
      default:
        return Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Align(
            alignment: movement(),
            child: Opacity(
              opacity: min(_animation!.value * 2, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Text(
                      pref.client?.name ?? '',
                      //  widget.text,
                      style: Get.textTheme.displayLarge!.copyWith(
                          color: kBlack.withOpacity(0.3),
                          fontSize: 18,
                          backgroundColor: kWhite.withOpacity(0.2)),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      pref.client?.phone ?? '',
                      style: Get.textTheme.displayLarge!.copyWith(
                          color: kBlack.withOpacity(0.3),
                          fontSize: 18,
                          backgroundColor: kWhite.withOpacity(0.2)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
