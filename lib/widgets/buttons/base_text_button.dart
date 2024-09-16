import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/loaders/loader.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_themes.dart';

class BaseTextButton extends StatefulWidget {
  final String title;
  final Rx<bool>? loading;
  final VoidCallback? onPress;
  final double height;
  final bool isOverlay;
  final double? minHeight;
  final double? width;
  final double? minWidth;
  final double radius;
  final String? svgImage;
  final String? fontFamily;
  final Color primary;
  final double fontSize;
  final IconData? iconData;
  final Color? borderColor;
  final Color? txtColor;
  final Color? arrowColor;
  final Color? backgroundColor;
  final bool showGradient;
  final bool showArrow;
  final bool showSpacer;
  final Widget? child;

  const BaseTextButton(
      {Key? key,
      required this.title,
      this.width,
      this.txtColor,
      this.iconData,
       this.loading,
      this.onPress,
      this.arrowColor = kPrimary,
      this.primary = kPrimary,
      this.radius = 25,
      this.svgImage,
      this.height = 45,
      this.fontFamily,
      this.minWidth,
      this.isOverlay = false,
      this.showSpacer = false,
      this.minHeight,
      this.child,
      this.borderColor,
      this.fontSize = 16,
      this.showArrow = false,
      this.backgroundColor = kPrimary,
      this.showGradient = false})
      : super(key: key);

  @override
  State<BaseTextButton> createState() => _BaseTextButtonState();
}

class _BaseTextButtonState extends State<BaseTextButton> {
  var load = false.obs;
  @override
  void initState() {
    if(widget.loading != null)  load.value = widget.loading!.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.showGradient
          ? BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  kPrimary,
                  kPrimaryDark,
                ],
              ),
              borderRadius: BorderRadius.circular(widget.radius),
              border: Border.all(color: widget.borderColor ?? kPrimary, width: 1))
          : const BoxDecoration(),
      child: ElevatedButton(
        onPressed: widget.onPress,
        style: widget.showGradient
            ? ElevatedButton.styleFrom(

                backgroundColor: Colors.transparent,
                //onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0
                //make color or elevated button transparent
              )
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  widget.backgroundColor,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      side:
                          BorderSide(color: widget.borderColor ?? kPrimary, width: 1)),
                ),
                minimumSize: widget.minWidth == null
                    ? null
                    : MaterialStateProperty.all(
                        Size(widget.minWidth!, widget.minHeight ?? 35)),
                fixedSize: widget.minWidth == null
                    ? MaterialStateProperty.all(
                        Size(widget.width ?? Get.width, widget.height))
                    : null,
              ),
        child: Obx(
          ()=> Row(
            mainAxisAlignment:(load.value || !widget.showArrow)?MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
            children: [
              if(load.value)
             const Loader(),
              if(!(load.value))
                if(!widget.isOverlay)
              widget.child ??
                    Text(
                      widget.title,
                      style: Get.textTheme.headlineMedium?.copyWith(
                          fontFamily: widget.fontFamily ?? kMedium,
                          fontSize: widget.fontSize,
                          color: widget.txtColor ?? kWhite),
                      maxLines: 1,
                    ),

              if(!(load.value))
                if(widget.isOverlay)
              Expanded(child:  widget.child ??
                  Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.displayMedium?.copyWith(
                        fontFamily: widget.fontFamily ?? kMedium,
                        fontSize: widget.fontSize,
                        color: widget.txtColor ?? kWhite),
                    maxLines: 1,
                  ),),
              if(!(load.value))
              if (widget.showArrow)
                Icon(
                  widget.iconData?? Icons.arrow_forward,
                  color: widget.txtColor ?? kWhite,
                ),

              // if(widget.showSpacer)
              //  const Spacer(),
              if(widget.svgImage != null)
                SvgPicture.asset(widget.svgImage!).paddingSymmetric(horizontal: 10),
            ],
          ),
        ),
      ),
    );
  }
}
