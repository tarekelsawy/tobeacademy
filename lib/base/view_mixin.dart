import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_theme_controllrt.dart';
import 'package:icourseapp/helper/auth_helper.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/bottom_nav_bar/bottom_bar.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/screens/home/tabs/account_tab/account_tab_screen.dart';
import 'package:icourseapp/screens/home/tabs/home_tab/home_tab_controller.dart';
import 'package:icourseapp/screens/notification/notification_screen.dart';
import 'package:icourseapp/screens/search/search_screen.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import '../models/api/page_attributes.dart';

mixin ViewMixin {
  ///Data
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///Getter &Setters
  PageAttributes get pageAttributes;

  Widget buildPage(BuildContext context) {
    return WillPopScope(onWillPop: pageAttributes.doLogout? onPopup: null, child: buildScaffold(context));
  }

  ///Build widgets methods
  Widget buildScaffold(BuildContext context) {
    return GetBuilder(
      init: Get.find<BaseThemeController>(),
      builder: (_) {
        return Scaffold(
            key: pageAttributes.isHome ? scaffoldKey : null,
            extendBodyBehindAppBar: pageAttributes.transparentAppBar || pageAttributes.isHome,
            drawerDragStartBehavior: DragStartBehavior.start,
            appBar: buildAppBar(),
            backgroundColor: _.isDarkTheme? kBlack:kWhite,
            body: GestureDetector(
                onTap: () {
                  if (Get.context != null) {
                    FocusScope.of(Get.context!).requestFocus(FocusNode());
                  }
                },
                child: Column(
                  children: [
                    if(pageAttributes.isHome)
                      SafeArea(
                        child: Column(
                          children: [
                            Row(

                              children: [
                                if(Get.isRegistered<HomeController>())
                                InkWell(
                                  onTap:()=> Get.to(()=> AccountTabScreen()),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                pref.client?.image ?? AppImages.avatar),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                if(Get.isRegistered<HomeController>())
                                GetBuilder<HomeController>(
                                  init: Get.find<HomeController>(),
                                  builder: (_) {
                                    return Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('مرحبا بك',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14,color: kPrimaryDark,fontWeight: FontWeight.w700),),
                                          Text(_.client?.name??'',style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),),
                                        ],
                                      ),
                                    );
                                  }
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.notification);
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.icNotification,
                                    height: 25,
                                    width: 25,
                                    color: kGreyAF,
                                  ),
                                ),

                                const SizedBox(width: 8,),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.qrCode);
                                  },
                                  child: const Icon(Icons.qr_code_2,size: 25,color: kGreyAF,),
                                ),

                              ],
                            ).paddingSymmetric(horizontal: 10).paddingOnly(bottom: 10),
                            InkWell(
                              child: Container(
                                height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: pref.darkTheme ? kWhite : kBlack)),
                                  child:  BaseTextField(
                                    onTap: ()=> Get.toNamed(Routes.search),
                                    hintTxt: 'ابحث عن كورس؟',
                                    fontSize: 14,
                                    readOnly: true,
                                  )).paddingSymmetric(horizontal: 20),
                            ),
                          ],
                        ).paddingOnly(top: 10),
                      ),
                    if( pageAttributes.showAppBar && pageAttributes.showLine && !pageAttributes.isHome)
                    Container(
                      height: 2,
                      width: Get.width,
                      color: kGreyF5,
                    ).paddingSymmetric(horizontal: 20),
                    Expanded(child: buildBody(context))
                  ],
                )),
            drawer: buildDrawer(),
            bottomNavigationBar: buildBottomBar(context),
            bottomSheet: buildSheet(),
            floatingActionButton: buildFloatButton(),
            resizeToAvoidBottomInset: pageAttributes.resizeToAvoidBottomInset);
      }
    );
  }

  ///get app-bar ***************************************************************
  PreferredSize? buildAppBar() {
    if (!pageAttributes.showAppBar || pageAttributes.isHome) return null;

    return PreferredSize(
      preferredSize: Size(Get.width, kToolbarHeight),
      child: GetBuilder(
        init: Get.find<BaseThemeController>(),
        builder: (_) {
          return AppBar(
              bottom: buildBottomAppBar(),
              systemOverlayStyle:  SystemUiOverlayStyle(
                statusBarIconBrightness: _.isDarkTheme
                    ? Brightness.light
                    : Brightness.dark,
              ),
              backgroundColor:
                  pageAttributes.transparentAppBar || pageAttributes.isHome ? Colors.transparent : _.isDarkTheme? kBlack:kWhite,
              elevation: 0,
              foregroundColor: Get.theme.scaffoldBackgroundColor,
              shadowColor: Get.theme.scaffoldBackgroundColor,
              actions: buildAppbarActions(),
              titleSpacing: 0,
              centerTitle: true,
              toolbarHeight: pageAttributes.toolbarHeight,
              leading: buildBackButton(),
              title: buildAppBarTitle());
        }
      ),
    );
  }

  ///Abstract - instance  methods to do extra work after init

  //set tool actions
  List<Widget> buildAppbarActions() {
    return [
      if(pageAttributes.isHome)
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 20),
          child: InkWell(
              onTap: ()=> Get.to(()=> SearchScreen()),
              child: const Icon(Icons.search,color: kGreyAF,size: 35,)),
        ),
      if(pageAttributes.isHome)
      Padding(
        padding: const EdgeInsetsDirectional.only(end: 20),
        child: InkWell(
          onTap: (){
            Get.toNamed(Routes.notification);
          },
          child: SvgPicture.asset(
            AppImages.icNotification,
            height: 25,
            width: 25,
            color: kGreyAF,
          ),
        ),
      ),

    ];
  }

  Widget? buildBackButton() {
    return Get.key.currentState!.canPop() && !pageAttributes.isHome
        ? Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 24,
                  color: kGreyD9,
                ),
                color: pageAttributes.backBtnColor,
                onPressed: () {
                  onPopup();
                },
              ),
            ],
          )
        : null;
  }

  //Build Drawer
  Widget? buildDrawer() {
    return null;
  }

  //Build Your Custom Body
  Widget buildBody(BuildContext context) {
    return SizedBox();
  }

  Widget? buildBottomBar(BuildContext context) {
    if(!pageAttributes.showNav) return null;
    if(!Get.isRegistered<HomeController>() || pageAttributes.isHome) return null;
    return BottomBar(
      controller: Get.find<HomeController>(),
    );
  }

  Widget? buildSheet() {
    return null;
  }

  PreferredSize? buildBottomAppBar() {
    return null;
  }

  Widget? buildFloatButton() {
    return null;
  }

  onNotificationIcClick() {}

  Widget buildAppBarTitle() {
    return GetBuilder(
      init: Get.find<BaseThemeController>(),
      builder: (_) {
        return Text(
          pageAttributes.title ?? '',
          style: Get.textTheme.displayMedium!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
        );
      }
    );
  }

  ///POP **************************
  Future<bool> onPopup() {
    Navigator.pop(Get.context!);
    return Future.value(true);
  }
}
