import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/theme/app_lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/base_text_button.dart';

class ConfirmationDialog extends StatefulWidget {
  final String text;
  final String? okText;
  final String? lottie;
  final num? score;
  final num? standard;
  final num? percentage;
  final String? cancelTxt;
  final bool showCancel;
  final GestureTapCallback onOkClick;
  final GestureTapCallback? onCancelClick;
  final double? minWidth;

  const ConfirmationDialog(
      {Key? key,
      required this.text,
      required this.onOkClick,
      this.onCancelClick,
      this.lottie,
      this.score,
      this.standard,
      this.percentage,
      this.showCancel = true,
      this.cancelTxt,
      this.minWidth,
      this.okText})
      : super(key: key);

  @override
  ConfirmationDialogState createState() => ConfirmationDialogState();
}

class ConfirmationDialogState extends State<ConfirmationDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Platform.isIOS) controller!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(children: [
      Material(
        color: Colors.transparent,
        child: Platform.isAndroid
            ? ScaleTransition(
                scale: scaleAnimation!,
                child: buildBody(context),
              )
            : buildBody(context),
      )
    ]));
  }

  String get grade =>  widget.score == null? '':((widget.score! / widget.standard!) * 100) >= 85
      ? 'امتياز'
      : ((widget.score! / widget.standard!) * 100) >= 75 && ((widget.score! / widget.standard!) * 100) < 85
          ? 'جيد جدا'
          : ((widget.score! / widget.standard!) * 100) >= 65 && ((widget.score! / widget.standard!) * 100) < 75
              ? 'جيد'
              : ((widget.score! / widget.standard!) * 100) >= 50 && ((widget.score! / widget.standard!) * 100) < 65? 'مقبول':'ضعيف';

  Widget buildBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints(minHeight: 180),
        decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGrayDark.withOpacity(0.1), width: 1)),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.score == null)
                    Center(
                      child: Lottie.asset(widget.lottie ?? '',
                          height: 150, width: 150),
                    ),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayMedium!
                        .copyWith(height: 1.6, fontSize: 16),
                  ),
                  if (widget.score != null)
                    CircularPercentIndicator(
                      animation: true,
                      addAutomaticKeepAlive: true,
                      radius: 60.0,
                      lineWidth: 10.0,
                      percent: (widget.score! / widget.standard!).toDouble(),
                      center: Text(
                        '${widget.standard} / ${widget.score}',
                        style:
                            Get.textTheme.displayLarge!.copyWith(fontSize: 30),
                      ),
                      progressColor: kPrimary,
                    ).paddingOnly(top: 10).paddingOnly(bottom: 20),


                  if (widget.score != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kPrimary)
                    ),
                    child: Text(grade,style: Get.textTheme.displayMedium!.copyWith(fontSize: 14, color: kPrimary),).paddingSymmetric(vertical: 8,horizontal: 12),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (widget.showCancel)
                      BaseTextButton(
                        title: widget.cancelTxt ?? 'cancel'.tr,
                        primary: kWhite,
                        borderColor: kRed,
                        minWidth: widget.minWidth,
                        width: widget.minWidth != null ? null : 140,
                        height: 35,
                        fontSize: 13,
                        txtColor: kRed,
                        radius: 8,
                        backgroundColor: kWhite,
                        onPress: () => Get.back(),
                      ),
                    if (widget.showCancel)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                    BaseTextButton(
                      title: widget.okText ?? 'ok'.tr,
                      minWidth: widget.minWidth,
                      width: widget.minWidth != null ? null : 140,
                      height: 35,
                      radius: 8,
                      fontSize: 13,
                      onPress: () => widget.onOkClick.call(),
                    )
                  ])
                ])));
  }
}
