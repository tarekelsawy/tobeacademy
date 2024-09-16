import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_view.dart';
import 'package:icourseapp/main.dart';
import 'package:icourseapp/models/api/page_attributes.dart';
import 'package:icourseapp/screens/home/tabs/report/report_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/utils/date_time_util.dart';
import 'package:icourseapp/widgets/must_logged_in.dart';

class ReportScreen extends BaseView {
  ReportScreen({Key? key}) : super(key: key);

  @override
  PageAttributes get pageAttributes =>
      PageAttributes(isHome: true, title: 'التقرير');

  @override
  Widget buildBody(BuildContext context) {
    return GetBuilder<ReportController>(
        init: ReportController(),
        builder: (controller) => !controller.isLoggedIn()
            ? const MustLoggedIn()
            : Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => controller.loading.value
                          ? const Center(
                              child: SpinKitPouringHourGlass(
                                color: kPrimary,
                                size: 50,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الاشتراكات',
                                  style: Get.textTheme.displayMedium!.copyWith(
                                      fontWeight: FontWeight.w700, fontSize: 16),
                                ).paddingOnly(bottom: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: controller.report!.enrollements
                                      .map((e) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width,
                                                decoration:  BoxDecoration(
                                                    color: pref.darkTheme? kPrimary18: kGreyEE),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (e.startDate != null)
                                                      Text(
                                                        'تاريخ البدايه: ${e.startDate}',
                                                        style: Get.textTheme
                                                            .displayMedium!
                                                            .copyWith(
                                                                fontSize: 14),
                                                      ),
                                                    if (e.endDate != null)
                                                      Text(
                                                        'تاريخ النهايه: ${e.endDate}',
                                                        style: Get.textTheme
                                                            .displayMedium!
                                                            .copyWith(
                                                                fontSize: 14),
                                                      ),
                                                    if (e.courseName != null)
                                                      Text(
                                                        'اسم الكورس: ${e.courseName}',
                                                        style: Get.textTheme
                                                            .displayMedium!
                                                            .copyWith(
                                                                fontSize: 14),
                                                      ),
                                                  ],
                                                ).paddingSymmetric(
                                                    horizontal: 10, vertical: 10),
                                              ),
                                              Container(
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: pref.darkTheme? kPrimary18: kGreyEE)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: e.enrollmentSections!
                                                      .map((ee) => Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                ee.name,
                                                                style: Get
                                                                    .textTheme
                                                                    .displayMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700),
                                                              ),
                                                              Text(
                                                                'تاريخ الاشتراك: ${DateTimeUtil.toddMMYYYYHHMMAFormat(ee.createdAt)}',
                                                                style: Get
                                                                    .textTheme
                                                                    .displayMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                              if (ee.name !=
                                                                  e.enrollmentSections
                                                                      ?.last.name)
                                                                Container(
                                                                  height: 1,
                                                                  width:
                                                                      Get.width,
                                                                  color: kGreyEE,
                                                                ).paddingSymmetric(
                                                                    vertical: 10),
                                                            ],
                                                          ))
                                                      .toList(),
                                                ).paddingSymmetric(
                                                    horizontal: 10, vertical: 10),
                                              ),
                                            ],
                                          ).paddingOnly(bottom: 10))
                                      .toList(),
                                ).paddingOnly(bottom: 20),
                                Text(
                                  'الحضور',
                                  style: Get.textTheme.displayMedium!.copyWith(
                                      fontWeight: FontWeight.w700, fontSize: 16),
                                ).paddingOnly(bottom: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: controller.report!.attendance
                                      .map((e) => Container(
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                border:
                                                    Border.all(color: kGreyEE)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (e.className != null)
                                                  Text(
                                                    '${e.className}',
                                                    style: Get
                                                        .textTheme.displayMedium!
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700),
                                                  ),
                                                if (e.attendanceDate != null)
                                                  Text(
                                                    'تاريخ الحضور: ${e.attendanceDate}',
                                                    style: Get
                                                        .textTheme.displayMedium!
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                if (e.categoryName != null)
                                                  Text(
                                                    'اسم الفئه: ${e.categoryName}',
                                                    style: Get
                                                        .textTheme.displayMedium!
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                if (e.subjectName != null)
                                                  Text(
                                                    'الموضوع: ${e.subjectName}',
                                                    style: Get
                                                        .textTheme.displayMedium!
                                                        .copyWith(fontSize: 14),
                                                  ),
                                              ],
                                            ).paddingSymmetric(
                                                horizontal: 10, vertical: 10),
                                          ).paddingOnly(bottom: 10))
                                      .toList(),
                                ),
                              ],
                            )),
                    ],
                  ).paddingSymmetric(horizontal: 20, vertical: 20),
                ),
            ));
  }
}
