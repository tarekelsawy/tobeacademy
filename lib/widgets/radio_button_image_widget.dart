import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/quiz.dart';
import 'package:icourseapp/theme/app_colors.dart';

class RadioItemImageWidget<T> extends StatelessWidget {
  final T item;
  final String? title;
  final T? groupValue;
  final bool isFinished;
  final Questions? questionVal;
  final ValueChanged<T?> onChecked;

  const RadioItemImageWidget({
    super.key,
    required this.item,
    required this.groupValue,
    required this.questionVal,
    required this.onChecked,
    required this.isFinished,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isFinished ? null : () => onChecked.call(item),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            border: Border.all(
                color: isFinished
                    ? questionVal!.choice == item
                        ? questionVal!.isCorrect
                            ? kGreen
                            : kRed
                        : questionVal!.rightChoice == item
                            ? kGreen
                            : pref.darkTheme
                                ? kWhite
                                : kBlack
                    : item == groupValue
                        ? kPrimary
                        : pref.darkTheme
                            ? kWhite
                            : kBlack)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? '',
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Theme(
                data: Theme.of(context).copyWith(
                    unselectedWidgetColor: pref.darkTheme ? kWhite : kBlack,
                    disabledColor: pref.darkTheme ? kWhite : kBlack),
                child: Radio(
                  activeColor: isFinished
                      ? questionVal!.choice == item
                          ? questionVal!.isCorrect
                              ? kGreen
                              : kRed
                          : questionVal!.rightChoice == item
                              ? kGreen
                              : kPrimary
                      : kPrimary,
                  value: item,
                  groupValue: groupValue,
                  onChanged: onChecked,
                  visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )),
          ],
        ).paddingSymmetric(horizontal: 5,vertical: 3),
      ),
    );
  }
}
