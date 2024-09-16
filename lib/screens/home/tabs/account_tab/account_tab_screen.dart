import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/models/args/register_args.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/account_screens/info/info_screen.dart';
import 'package:icourseapp/screens/home/tabs/account_tab/account_tab_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';

import '../../../auth/register/register_controller.dart';

class AccountTabScreen extends BaseView {
  AccountTabScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(showNav: false, showLine: false);

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<AccountTabController>(
        init: AccountTabController(),
        builder: (controller) {
          return SingleChildScrollView(
              child: Column(
            children: [
              if (controller.isLoggedIn())
                Container(
                  height: 155,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: kPrimary, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _item(
                          title: pref.client?.name ?? '',
                          avatar: true,
                          onPress: () => null)
                          .paddingOnly(bottom: 10, left: 20, right: 20),
                    ],
                  ),
                ).paddingOnly(bottom: 15, top: 10),
              if (controller.isLoggedIn())
                _item(
                    title: 'تعديل الحساب',
                    icon: Icons.edit_note_sharp,
                    onPress: () => Get.toNamed(Routes.register,arguments: RegisterArgs(action: DataAction.edit)))
                    .paddingOnly(bottom: 15),

              if (controller.isLoggedIn())
                _item(
                        title: 'تأكيد الحضور',
                        icon: Icons.qr_code_2,
                        onPress: () => Get.toNamed(Routes.qrCode))
                    .paddingOnly(bottom: 15),
              _item(
                      title: 'المقالات',
                      icon: Icons.library_books,
                      onPress: () => Get.toNamed(Routes.blogs))
                  .paddingOnly(bottom: 15),
              _item(
                      title: 'الشروط والاحكام',
                      icon: Icons.privacy_tip,
                      onPress: () => Get.toNamed(Routes.terms))
                  .paddingOnly(bottom: 15),
              _item(
                      title: 'تواصل معانا',
                      icon: Icons.contacts,
                      onPress: () => Get.toNamed(Routes.contact))
                  .paddingOnly(bottom: 15),
              if (controller.isLoggedIn())
                _item(
                        title: 'تسجيل الخروج',
                        icon: Icons.exit_to_app,
                        onPress: controller.confirmLogout)
                    .paddingOnly(bottom: 15),
              if (!controller.isLoggedIn())
                _item(
                        title: 'تسجيل الدخول',
                        icon: Icons.person,
                        onPress: () => Get.toNamed(Routes.auth))
                    .paddingOnly(bottom: 15),
              if (controller.isLoggedIn())
                _item(
                        title: 'حذف الحساب',
                        icon: Icons.delete,
                        onPress: controller.deleteAccount)
                    .paddingOnly(bottom: 15),
              Obx(
                () => _item(
                        title: 'الوضع الليلي',
                        icon: Icons.dark_mode,
                        onPress: () {},
                        onSwitcherChange: controller.onSwitcherChange,
                        switcherValue: controller.isDark.value,
                        switcher: true)
                    .paddingOnly(bottom: 15),
              ),
            ],
          ).paddingSymmetric(horizontal: 20, vertical: 10));
        });
  }

  Widget _item(
      {required String title,
      IconData? icon,
      required Function onPress,
      bool switcher = false,
      bool avatar = false,
      bool switcherValue = false,
      ValueChanged<bool?>? onSwitcherChange}) {
    return InkWell(
      onTap: () => onPress.call(),
      child: Card(
        color: pref.darkTheme ? kPrimary18 : kGreyF9,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            if (avatar)
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            pref.client?.image ?? AppImages.avatar),
                        fit: BoxFit.cover)),
              ),
            if (!avatar)
              Icon(
                icon,
                color: kPrimary,
              ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!avatar)
                  Text(
                    title,
                    style: Get.textTheme.displayLarge!.copyWith(
                        fontSize: 16, color: pref.darkTheme ? kWhite : kBlack),
                  ),
                if (avatar)
                  if (avatar)
                    Text(
                      title,
                      style: Get.textTheme.displayLarge!.copyWith(
                          fontSize: 16,
                          color: kPrimary,
                          fontWeight: FontWeight.w700),
                    ),
                if (avatar)
                  Text(
                    pref.client?.phone ?? '',
                    style: Get.textTheme.displayLarge!.copyWith(
                        fontSize: 14, color: pref.darkTheme ? kWhite : kBlack),
                  ),
                if (avatar)
                  Text(
                    'النقاط:  ${pref.client?.points}',
                    style: Get.textTheme.displayLarge!.copyWith(
                        fontSize: 14, color: pref.darkTheme ? kWhite : kBlack),
                  ),
              ],
            )),
            if (switcher)
              Switch(
                  activeColor: kPrimary,
                  inactiveTrackColor: pref.darkTheme ? kWhite : kGreyA9,
                  activeTrackColor: pref.darkTheme ? kWhite : kGreyA9,
                  value: switcherValue,
                  onChanged: (value) => onSwitcherChange?.call(value)),
            if (!switcher && !avatar)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: pref.darkTheme ? kWhite : kGreyA9,
              )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: switcher ? 0 : 10),
      ),
    );
  }
}
