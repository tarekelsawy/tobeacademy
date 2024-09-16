import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/organization.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';

class OrganizationWidget extends StatelessWidget {
  final Organization organization;
  final ValueChanged<CategoriesArgs> onTap;
  const OrganizationWidget({Key? key, required this.organization, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap.call(CategoriesArgs(id: organization.id, name: organization.name)),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          border: Border.all(
              color: Get.theme.textTheme.displayMedium?.color!.withOpacity(0.5) ?? kPrimary,
              width: 0.8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: CachedNetworkImage(
                imageUrl: organization.image ?? AppImages.failUrl,
                alignment: Alignment.center,
                height: 130,
                width: Get.width,
                fit: BoxFit.cover,
                errorWidget: (context, url, data) => CachedNetworkImage(
                  imageUrl: AppImages.failUrl,
                  alignment: Alignment.center,
                  height: 130,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SpinKitCircle(
                      color: kPrimary,
                      size: 30,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: SpinKitCircle(
                    color: kPrimary,
                    size: 30,
                  ),
                ),
              ),
            ).paddingOnly(bottom: 10),
            Text(
              organization.name,
              style: Get.textTheme.displayMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimary,),
            ),
          ],
        ),
      ).paddingOnly(bottom: 10),
    );
  }
}
