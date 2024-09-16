import 'dart:io';

import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/categories_args.dart';
import 'package:icourseapp/models/organization.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/tabs/home_tab/home_tab_repository.dart';
import '../../../../models/course.dart';

class HomeTabController extends SwipeableController {
  @override
  loadMore() {
    stopLoading();
  }

  @override
  onRefresh() {
    stopLoading();
    // organization.clear();
    // _getOrganization();
  }

  @override
  injectRepository() {
    Get.put(HomeTabRepository());
  }

  @override
  onDestroy() {
    Get.delete<HomeTabRepository>();
  }

  @override
  onCreate() async{
    loading.value = true;
    loadData = true;
    paginationEnabled(false);
    _getOrganization();
    loadNewCourse.value = true;
    loadFeaturedCourse.value = true;
    _getFeaturedCourses();
    _getNewCourses();
  }

  @override
  HomeTabRepository get repository => Get.find();

  /// Data ****************************************************
  var organization = <Organization>[];
  var loadData = false;
  var loadNewCourse = false.obs;
  var loadFeaturedCourse = false.obs;
  List<Course> featuredCourses = [];
  List<Course> newCourses = [];


  /// Listeners ********************************************************
  onNavigateToCategoriesArgs(CategoriesArgs args)async{
    await Get.toNamed(Routes.categories,arguments: args);
  }


  onCourseNavigate(Course course) {
    Get.toNamed(Routes.courseDetails, arguments: course);
  }

  /// Logic ****************************************************
  _organizationResponse(Resource resource) {
    stopLoading();
    if (resource.isError()) return;
    organization.addAll(resource.data);
    if(organization.length > 2){
      organization = [organization[0], organization[1]];
    }
    update();
  }

  _coursesResponse(Resource resource) {
    loadFeaturedCourse.value = false;
    if (resource.isError()) return;
    featuredCourses = resource.data;
    if(featuredCourses.length > 2){
      featuredCourses = [featuredCourses[0], featuredCourses[1]];
    }
    update();
  }

  _coursesNewResponse(Resource resource) {
    loadNewCourse.value = false;
    if (resource.isError()) return;
    newCourses = resource.data;
    if(newCourses.length > 2){
      newCourses = [newCourses[0], newCourses[1]];
    }
    update();
  }

  /// Api Requests *********************************************
  _getOrganization() async {
    var resource = await repository.getOrganizations();
    _organizationResponse(resource);
  }

  _getFeaturedCourses() async {
    var resource = await repository.getFeaturedCourses();
    _coursesResponse(resource);
  }

  _getNewCourses() async {
    var resource = await repository.getNewCourses();
    _coursesNewResponse(resource);
  }




}
