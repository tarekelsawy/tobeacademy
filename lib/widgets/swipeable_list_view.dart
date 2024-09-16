import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../base/swipable_refresh.dart';
import '../base/swipeable_controller.dart';
import '../theme/app_colors.dart';

class SwipeableListView extends StatelessWidget {
  ///Data - Constructor *****************
  final SwipeableController controller;
  final int itemsCount;
  final IndexedWidgetBuilder? itemBuilder;
  final double headerTrigger;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final String? emptyPlaceholder;
  final Widget? emptyWidget;
  final Widget? separator;

  const SwipeableListView(
      {Key? key,
      required this.controller,
      this.emptyWidget,
      this.separator,
      required this.itemsCount,
      this.itemBuilder,
      this.child,
      this.emptyPlaceholder,
      this.headerTrigger = 5,
      this.padding})
      : super(key: key);

  ///Build ******************************
  @override
  Widget build(BuildContext context) {
    controller.setRefreshListeners();
    return FRefresh(
        header: SizedBox(
          height: 5,
          child: LinearProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
              backgroundColor: kPrimary.withOpacity(0.7)),
        ),
        controller: controller.refreshController,
        shouldLoad: controller.footerEnabled,
        headerHeight: 5,
        headerTrigger: headerTrigger,
        headerBuilder: (__, ___) => SizedBox(
              height: 5,
              width: Get.width,
              child: LinearProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
                  backgroundColor: kPrimary.withOpacity(0.7)),
            ),
        footerHeight: controller.footerEnabled ? 10 : 0,
        footer: SizedBox(
          height: 10,
          child: LinearProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
              backgroundColor: kPrimary.withOpacity(0.7)),
        ),
        child: itemsCount == 0
            ? IntrinsicHeight(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emptyWidget ??
                          SizedBox(
                            // height: 200,
                            width: 150,
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                emptyPlaceholder ?? 'assets/images/no_result.png',
                                color: Get.textTheme.displayMedium!.color,
                                colorBlendMode: BlendMode.srcIn,
                              ),
                            ),
                          ).paddingOnly(bottom: 10),
                      Text('لا يوجد نتائج', style: Get.textTheme.displayMedium!.copyWith(fontSize: 14),),
                    ],
                  ),
                ),
              )
            : child ??
                ListView.separated(
                    separatorBuilder: (_, index) =>
                        separator ?? const SizedBox(),
                    itemCount: itemsCount,
                    padding: padding,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: itemBuilder ?? (_, __) => const SizedBox()));
  }
}
