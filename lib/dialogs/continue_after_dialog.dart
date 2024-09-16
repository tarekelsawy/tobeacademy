import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_themes.dart';
import '../theme/app_colors.dart';
import '../utils/string_utils.dart';

class ContinueAfterDialog extends StatefulWidget {
  final int? startSecond;
  final GestureTapCallback? onFinished;

  const ContinueAfterDialog({Key? key, @required this.startSecond, @required this.onFinished}) : super(key: key);

  @override
  _ContinueAfterDialogState createState() => _ContinueAfterDialogState();
}

class _ContinueAfterDialogState extends State<ContinueAfterDialog>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late int _start;
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    _start = widget.startSecond!;
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Platform.isIOS) controller!.forward();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startTimer();
      });
    });
  }

  _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = 0;
            timer.cancel();
            widget.onFinished?.call();
            Get.back();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(children: [
      Material(
        color: Colors.transparent,
        child:  Platform.isAndroid?ScaleTransition(
          scale: scaleAnimation!,
          child: buildBody(context),
        ):buildBody(context),
      )
    ]));
  }

  Widget buildBody(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      constraints: const BoxConstraints(minHeight: 210),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.4), width: 1)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'you_can_continue_after'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kBlack,
                  height: 1.55,
                  fontFamily: kLight,
                  fontSize: 16),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
            Text(
              StringUtils.timeFromSeconds(_start),
              style: TextStyle(
                  color: kPrimary,
                  fontSize: 20,
                  fontFamily: kBold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller?.dispose();
    super.dispose();
  }
}
