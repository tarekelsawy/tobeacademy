import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/courses/categories_courses_repository.dart';
import 'package:icourseapp/screens/courses/widgets/filter.dart';

class CategoriesCoursesController extends SwipeableController {
  @override
  loadMore() {
    if(loading.value || paginationData!.isLastPage){
      stopLoading();
      // paginationEnabled(false);
      return;
    }
    _getCourses();
  }

  @override
  onRefresh() {
    // paginationEnabled(true);
    resetPagination();
    courses.clear();
    _getCourses();
  }

  @override
  onCreate() {
    loading.value = true;
    _getSubject();
    _getCourses();
  }

  @override
  onDestroy() {
    Get.delete<CategoriesCoursesRepository>();
  }

  @override
  CategoriesCoursesRepository get repository => Get.put(CategoriesCoursesRepository());

  /// Data ********************************************************
  CategoriesArgs args = Get.arguments;
  var courses = <Course>[];
  var subjects = <Category>[];
  Category? selected;
  /// Listeners ********************************************************
  onNavigateToDetails(Course course) async {
    await Get.toNamed(Routes.courseDetails, arguments: course);
  }

  onFilter()async{
    dynamic res = await Get.bottomSheet(
        SubjectFilter(categories: subjects,selected: selected,),
        elevation: 4,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: true);
    if(res == null) return;
    selected = res;
    loading.value = true;
    onRefresh();
  }
  /// Logic ****************************************************
  _coursesResponse(Resource resource) async{

    stopLoading();
    if (resource.isError()) return;
    courses.addAll(resource.data);
    paginationData = resource.paginationData;
    setNextPage();
    update();
  }

  /// Api Requests *********************************************
  _getCourses() async {
    var resource = await repository.getCourses(id: args.id,page: paginationData?.page??1, subjectId: selected?.id);
    _coursesResponse(resource);
  }

  _getSubject()async{
    var res = await repository.getSubject();
    if(res.isSuccess()){
      subjects = res.data;
      update();
    }
  }
}
