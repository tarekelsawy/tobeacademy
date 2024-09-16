import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/tabs/my_courses/my_courses_repository.dart';
import 'package:icourseapp/screens/search/search_repository.dart';

class AppSearchController extends SwipeableController{
  @override
  loadMore() {
    if(loading.value || paginationData!.isLastPage){
      stopLoading();
      return;
    }
    _getCourses();
  }

  @override
  onRefresh() {
    if(search.text.trim().isEmpty) {
      stopLoading();
      return;
    }
    resetPagination();
    courses.clear();
    _getCourses();
  }
  @override
  injectRepository() {
    Get.put(SearchRepository());
  }

  @override
  onDestroy() {
    Get.delete<SearchRepository>();
    timer?.cancel();
  }

  @override
  onCreate() {
    // loading.value = true;
    // _getCourses();
  }

  @override
  SearchRepository get repository => Get.find();



  /// listeners *******************************************
  onCourseNavigate(Course course){
    Get.toNamed(Routes.courseDetails,arguments: course);
  }

  onSearch(String? value){
    print('================= ${value}');
    timer?.cancel();
    if(value == null || value.isEmpty){
      resetPagination();
      courses.clear();
      update();
      return;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_timer) {
      loading.value = true;
      onRefresh();
      timer?.cancel();
    });
  }
  /// Data *************************************************
  List<Course> courses = [];
  TextEditingController search = TextEditingController();
  Timer? timer;

  /// logic ***************************************
  _coursesResponse(Resource resource){
    stopLoading();
    if(resource.isError()) return;
    courses.addAll(resource.data);
    paginationData = resource.paginationData;
    setNextPage();
    update();
  }
  /// Api Requests ***************************************
  _getCourses()async{
    var resource = await repository.getSearch(paginationData: paginationData!, searchQuery: search.text);
    _coursesResponse(resource);
  }
}