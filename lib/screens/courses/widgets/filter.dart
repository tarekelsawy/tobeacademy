import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/theme/app_colors.dart';

class SubjectFilter extends StatelessWidget {
  final List<Category> categories;
  final Category? selected;

  const SubjectFilter(
      {Key? key, required this.categories, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('اختيار المادة',style: Get.textTheme.displayMedium!.copyWith(fontSize: 16),).paddingOnly(bottom: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: categories
                      .map((e) => Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.back(result: e);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                    e.name,
                                    style: Get.textTheme.displayMedium!
                                        .copyWith(fontSize: 16,color: kWhite),
                                  ),
                              Row(
                                children: [
                                  if (selected?.id == e.id)
                                    const Icon(
                                      Icons.done,
                                      color: kWhite,
                                    )
                                ],
                              ),
                            ],
                          ).paddingSymmetric(vertical: 5,horizontal: 10),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: Get.width,
                        color:  kGreyA9,
                      ).paddingSymmetric(vertical: 10),
                    ],
                  ))
                      .toList(),
                ),
              ),
            ),
          ] ,
        ).paddingSymmetric(vertical: 10),
      ),
    );
  }
}
