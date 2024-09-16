import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class SuccessSheet extends StatefulWidget {

  const SuccessSheet({Key? key}) : super(key: key);

  @override
  _PaymentSheetState createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<SuccessSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: [
          Container(
            width: Get.width,
              height: 205,
              decoration: const BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kWhite)
                      ),
                      child: const Icon(Icons.done,color: kWhite,).paddingAll(10),
                    ).paddingOnly(bottom: 15),
                    Text(
                      'Payment Succeeded',
                      style: Get.textTheme.headlineLarge!
                          .copyWith(fontSize: 16, color: kWhite),
                    )
                  ],
                ).paddingSymmetric(horizontal: 16,vertical: 16),
              ))
        ],
      );
  }
}

