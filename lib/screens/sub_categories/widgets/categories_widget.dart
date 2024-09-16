import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';

class SubCategoriesWidget extends StatelessWidget {
  final Category category;
  final ValueChanged<CategoriesArgs> onTap;
  const SubCategoriesWidget({Key? key, required this.category, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap.call(CategoriesArgs(id: category.id, name: category.name)),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
              color: Get.theme.textTheme.displayMedium?.color ?? kPrimary,
              width: 0.2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: CachedNetworkImage(
                imageUrl: category.image ?? AppImages.failUrl,
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
              category.name,
              textAlign: TextAlign.center,
              style: Get.textTheme.displayMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ).paddingOnly(bottom: 10),
    );
  }
}
