import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/account_screens/contact_us/contact_us_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';

class ContactUsScreen extends BaseView<ContactUsController> {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes => PageAttributes(title: 'تواصل معانا',showNav: false);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder(
        init: controller,
        global: false,
        assignId: true,
        tag: tag,
        builder: (_) {
          return Obx(
            () => _.loading.value
                ? const Center(
                    child: SpinKitCubeGrid(
                      color: kPrimary,
                      size: 30,
                    ),
                  )
                : Column(
              children: _.contact.map((e) => InkWell(
                onTap: (){
                  if((e)['key'].toString().toLowerCase() == 'facebook'){
                    controller.launch(
                        url: e['value'] ??
                            '');
                  }else if ((e)['key'].toString().toLowerCase() == 'mobile'){
                    controller.launch(
                        url:
                        'tel:${e['value'] ?? ''}');
                  }else if ((e)['key'].toString().toLowerCase() == 'whatsapp'){
                    controller.launchWhatsApp(
                        phone: e['value'] ??
                            '');
                  }
                },
                child: Card(
                  color: pref.darkTheme? kPrimary18:kWhite,
                  shadowColor: !pref.darkTheme? kPrimary18:kWhite,
                  elevation: 2,
                  child: Row(
                    children: [
                      if((e as Map)['key'].toString().toLowerCase() == 'facebook')
                        Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xFF1877F2),
                                shape: BoxShape.circle),
                            child:  Center(
                              child: SvgPicture.asset(AppImages.icFace,color: kWhite,height: 18,),
                            )),
                      if((e)['key'].toString().toLowerCase() == 'mobile')

                        InkWell(
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  color: kPrimary,
                                  shape: BoxShape.circle),
                              child: const Center(
                                child:  Icon(
                                  Icons.phone_android,
                                  size: 20,
                                  color: kWhite,
                                ),
                              )),
                        ),

                      if((e)['key'].toString().toLowerCase() == 'address')
                        InkWell(
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  color: kPrimaryGreen,
                                  shape: BoxShape.circle),
                              child: const Center(
                                child:  Icon(
                                  Icons.location_on_sharp,
                                  size: 20,
                                  color: kWhite,
                                ),
                              )),
                        ),

                      if((e)['key'].toString().toLowerCase() == 'whatsapp')
                        Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xff25d366),
                                shape: BoxShape.circle),
                            child: const Center(
                              child:  Icon(
                                Icons.phone,
                                size: 20,
                                color: kWhite,
                              ),
                            )),
                      const SizedBox(width: 10,),
                      Text(e['title'], style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),),
                    ],
                  ).paddingSymmetric(horizontal: 12,vertical: 8),
                ).paddingOnly(bottom: 10),
              )).toList(),
            ).paddingSymmetric(horizontal: 20,vertical: 20),
          );
        });
  }
}
