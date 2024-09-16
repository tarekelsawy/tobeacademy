import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_images.dart';
import '../widgets/buttons/base_text_button.dart';

class SheetInfo extends StatefulWidget {

  final String? title;
  final Function? onOk;
  final String? btnTitle;

  const SheetInfo({Key? key, this.title, this.onOk, this.btnTitle}) : super(key: key);

  @override
  _SheetInfoState createState() => _SheetInfoState();
}

class _SheetInfoState extends State<SheetInfo> {

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          ),
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: 75,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  Text(
                    widget.title ?? 'must_login_txt'.tr,
                    style: Get.textTheme.headlineMedium!.copyWith(color: kBlueBlack,fontSize: 18,height: 1.5),
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  BaseTextButton(
                      onPress:() => widget.onOk?.call() ,
                      radius: 12,
                      title: widget.btnTitle ?? 'ok'.tr).paddingSymmetric(horizontal: 16)
                ]).paddingSymmetric(vertical: 16),
          ))
    ],);
  }
}
