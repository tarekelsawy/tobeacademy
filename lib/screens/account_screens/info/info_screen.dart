import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_images.dart';

class Info extends BaseView {
   Info({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: 'حسابي',showNav: false);

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Get.theme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4,
          shadowColor: Get.textTheme.displayMedium!.color ?? kGreyF5,
          child: SizedBox(
            width: Get.width,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircularPercentIndicator(
                      animation: true,
                      addAutomaticKeepAlive: true,
                      radius: 60.0,
                      lineWidth: 8.0,
                      percent: (double.tryParse(pref.client?.points??'')??0) / 1000,
                      center: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    pref.client?.image ?? AppImages.avatar),
                                fit: BoxFit.cover)),
                      ),
                      progressColor: kPrimary,
                    ).paddingOnly(bottom: 20),
                  ),

                  Text('الاسم',style: Get.textTheme.displayLarge!.copyWith(fontSize: 16),).paddingOnly(bottom: 10),
                  Text(pref.client?.name??'',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),).paddingOnly(bottom: 20),

                  Text('البريد الالكتروني',style: Get.textTheme.displayLarge!.copyWith(fontSize: 16),).paddingOnly(bottom: 10),
                  Text(pref.client?.email??'',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),).paddingOnly(bottom: 20),

                  if(pref.client?.address != null)
                  Text('العنوان',style: Get.textTheme.displayLarge!.copyWith(fontSize: 16),).paddingOnly(bottom: 10),
                  if(pref.client?.address != null)
                  Text(pref.client?.address??'',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),).paddingOnly(bottom: 20),

                  if(pref.client?.phone != null)
                    Text('الهاتف',style: Get.textTheme.displayLarge!.copyWith(fontSize: 16),).paddingOnly(bottom: 10),
                  if(pref.client?.phone != null)
                    Text(pref.client?.phone??'',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),).paddingOnly(bottom: 20),


                ],
              ).paddingSymmetric(horizontal: 20,vertical: 10),
          ),
        ).paddingSymmetric(horizontal: 20,vertical: 10),
      ],
    );
  }


}
