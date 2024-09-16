import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_images.dart';

class CategoriesWidget extends StatelessWidget {
  final Category category;
  final double height;
  final ValueChanged<CategoriesArgs> onTap;
  const CategoriesWidget({Key? key, required this.category, required this.onTap, this.height = 130}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap.call(CategoriesArgs(id: category.id, name: category.name)),
      child: Container(
        width: 150,
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
                imageUrl: category.image ?? AppImages.failUrl,
                alignment: Alignment.center,
                height: height,
                width: Get.width,
                fit: BoxFit.cover,
                errorWidget: (context, url, data) => CachedNetworkImage(
                  imageUrl: AppImages.failUrl,
                  alignment: Alignment.center,
                  height: height,
                  width: Get.width,
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => const Center(
                  //   child: SpinKitCircle(
                  //     color: kPrimary,
                  //     size: 30,
                  //   ),
                  // ),
                ),
                // placeholder: (context, url) => const Center(
                //   child: SpinKitCircle(
                //     color: kPrimary,
                //     size: 30,
                //   ),
                // ),
              ),
            ).paddingOnly(bottom: 10),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: Get.textTheme.displayMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700,color: kPrimary,),
            ),

            // if(category.courseCount != null)
            // Text(
            //   '${category.courseCount??' '} كورس ',
            //   textAlign: TextAlign.center,
            //   style: Get.textTheme.displayMedium!
            //       .copyWith(fontSize: 12,),
            //
            // ),
          ],
        ),
      ).paddingOnly(bottom: 10),
    );
  }
}
