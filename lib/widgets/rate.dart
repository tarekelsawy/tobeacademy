
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_lottie.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:icourseapp/widgets/base_text_field.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';
import 'package:icourseapp/widgets/star_rating.dart';
import 'package:lottie/lottie.dart';

class RateUserSheet extends StatefulWidget {
  final Function(String, int)? onConfirmRate;
  final String title;
  final String subTitle;
  const RateUserSheet(
      {super.key,
        this.onConfirmRate,
        required this.title,
        required this.subTitle});

  @override
  State<RateUserSheet> createState() => _RateUserSheetState();
}

class _RateUserSheetState extends State<RateUserSheet> {
  TextEditingController rateController = TextEditingController();
  int rating = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration:  BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Close ***********************************************************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    widget.title,
                    style: Get.textTheme.displayLarge!.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close_sharp,
                          color: kGreyA9, size: 20)),
                ],
              ),

              /// Image ************************************************************

              Lottie.asset(AppLottie.star),

              /// Title ************************************************************

              Text(
                widget.subTitle,
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),

              /// Rate Bar ************************************************************

              StarRating(
                starsCenter: true,
                  iconSize: 40,
                  onRatingChanged: (rating) =>
                      setState(() => this.rating = rating.toInt()),
                  rating: rating.toDouble()),
              const SizedBox(height: 10),

              /// Rate Input ************************************************************
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Get.textTheme.displayMedium!.color!)
                ),
                child: BaseTextField(
                  controller: rateController,
                  hintTxt: 'ادخل تقيمك',
                  maxLines: 10,
                ),
              ),
              const SizedBox(height: 10),

              /// send Button ************************************************************
              RoundedLoadingButton(
                title: 'ارسال'.tr,
                height: 55,
                color: kPrimary,
                progressColor: kWhite,
                textColor: kWhite,
                onPressed: () {
                  if ( rating == 0) {
                    Get.snackbar('', '',
                        duration: const Duration(seconds: 2),
                        backgroundColor: kRed,
                        colorText: Colors.white,
                        instantInit: false,
                        titleText: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ادخل تقيمك',
                              style: Get.textTheme.displayLarge?.copyWith(fontSize: 16,color: kWhite),
                            ),
                          ],
                        ),
                        snackPosition: SnackPosition.TOP);
                  } else {
                    widget.onConfirmRate!.call(rateController.text, rating);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
