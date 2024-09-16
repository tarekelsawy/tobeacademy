import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  const EmptyWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/no_result.png',
                  color: Get.textTheme.displayMedium!.color,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ).paddingOnly(bottom: 10),
            Text(text??'لا يوجد نتائج', style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),),
          ],
        ),
      );
  }
}
