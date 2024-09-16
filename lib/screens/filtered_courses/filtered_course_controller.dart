import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/screens/filtered_courses/filtered_course_repository.dart';

import '../../navigation/app_routes.dart';

class FilteredCourseController extends SwipeableController {
  @override
  FilteredCourseRepository get repository => Get.find(tag: tag);

  @override
  loadMore() {
    if (loading.value || paginationData!.isLastPage) {
      stopLoading();
      return;
    }
    _getCourses();
  }

  @override
  onRefresh() {
    resetPagination();
    courses.clear();
    _getCourses();
  }

  @override
  onCreate() {
    loading.value = true;
    _getCourses();
  }

  /// listeners *******************************************
  onCourseNavigate(Course course) {
    Get.toNamed(Routes.courseDetails, arguments: course);
  }

  /// Data **************************************************
  int args = Get.arguments;
  var courses = <Course>[];

  /// logic ***************************************
  _coursesResponse(Resource resource) {
    stopLoading();
    if (resource.isError()) return;
    courses.addAll(resource.data);
    paginationData = resource.paginationData;
    setNextPage();
    update();
  }

  /// Api Requests ***************************************
  _getCourses() async {
    var resource = args == 1
        ? await repository.getFeaturedCourses(paginationData: paginationData!)
        : await repository.getNewCourses(paginationData: paginationData!);
    _coursesResponse(resource);
  }
}
