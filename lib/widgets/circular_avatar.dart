import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../theme/app_images.dart';

class CircularAvatar extends StatelessWidget {
  /// Data *********************************************************************
  final String? avatarUrl;
  final Function? onTap;
  final double size;
  final double archRadius;
  final double archLineSize;
  final double borderWidth;
  final double? progress;
  final String placeHolder;
  final bool fromFile;
  final bool locked;
  final Color borderColor;
  final bool isElevated;
  final bool showBorder;

  /// Constructors *************************************************************
  const CircularAvatar({Key? key,
    this.avatarUrl,
    this.size = 40,
    this.borderWidth=2,
    this.onTap,
    this.progress,
    this.locked = false,
    this.borderColor = kPrimary,
    this.showBorder=false,
    this.isElevated = false,
    this.placeHolder = '',
    this.archRadius = 50,
    this.archLineSize = 8,
    this.fromFile= false})
      : super(key: key);


  /// Build ********************************************************************
  @override
  Widget build(BuildContext context) {
    return locked? _lockedCircle() : progress == null
        ? _innerAvatar()
        : CircularPercentIndicator(
      radius: archRadius,
      // backgroundColor: kBlueGray,
      animation: true,
      progressColor: kPrimary,
      percent: progress!,
      lineWidth: archLineSize,
      center: _innerAvatar(),
    );
  }

  Widget _lockedCircle(){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kGrayD5,
        border: Border.all(color: kGrayDark, width: 1), boxShadow: !isElevated ? null: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],),
      child: const Center(child: Icon(Icons.lock_rounded, size: 32, color: kGrayDark,),),
    );
  }
  Widget _innerAvatar() {
    return InkWell(
        onTap: () => onTap == null ? null : onTap!.call(),
        child:
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kWhite,
              image: DecorationImage(
                  image: avatarUrl == null || avatarUrl!.isEmpty
                      ? AssetImage(placeHolder): fromFile? FileImage(File(avatarUrl!))
                      : CachedNetworkImageProvider(avatarUrl!) as ImageProvider,
                  fit: BoxFit.cover),
              border: Border.all(color: borderColor, width: showBorder?borderWidth:0.1), boxShadow: !isElevated ? null: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],),
        ));
  }
}
