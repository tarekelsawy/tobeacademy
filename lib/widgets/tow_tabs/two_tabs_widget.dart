import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/models/args/tab_args.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/widgets/tow_tabs/two_tabs_controller.dart';


class TwoTabsWidget extends StatelessWidget {
  final List<TabArgs> tabArgs;
  final int? initValue;
  final ValueChanged<int> onSelect;
  final String? tag;
  final Color? selected;
  final Color? disable;
  final Color? disableText;
  final Color? selectedText;
  final double? padding;
  const TwoTabsWidget(
      {Key? key,
      required this.tabArgs,
      required this.onSelect,
      this.padding,
      this.selected,
      this.disable,
      this.disableText,
      this.selectedText,
      this.initValue,
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        tag: tag ?? 'widget',
        init: TwoTabsController()..init(tabArgs,init: initValue),
        builder: (controller) {
          return Column(
            children: [
              Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: disable?? kGreyEE),
                child: Row(
                    children: controller.tabs
                        .map((e) => Expanded(
                              child:  InkWell(
                                  onTap: () {
                                    controller.onSelectedTab(e);
                                    onSelect.call(e.tabId);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: controller.selectedId == e.tabId
                                            ? selected?? kPrimaryGreen
                                            : null),
                                    child: Center(
                                      child: Text(
                                        e.title.tr,
                                        style: Get.textTheme.displayMedium!
                                            .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                          color: controller.selectedId ==
                                              e.tabId
                                              ? selectedText?? kPrimary
                                              : disableText?? kGreyA9,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                            ))
                        .toList()),
              ).paddingSymmetric(horizontal: padding ?? 25),
            ],
          );
        });
  }
}
