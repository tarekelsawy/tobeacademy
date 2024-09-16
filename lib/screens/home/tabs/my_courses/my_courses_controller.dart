import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/tabs/my_courses/my_courses_repository.dart';

class MyCoursesController extends SwipeableController{
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
    resetPagination();
    courses.clear();
    _getCourses();
  }
  @override
  injectRepository() {
    Get.put(MyCoursesRepository());
  }

  @override
  onDestroy() {
    Get.delete<MyCoursesRepository>();
  }

  @override
  onCreate() {
    if(!isLoggedIn()) return;
    loading.value = true;
    _getCourses();
  }

  @override
  MyCoursesRepository get repository => Get.find();


  /// listeners *******************************************
  onCourseNavigate(Course course){
    Get.toNamed(Routes.courseDetails,arguments: course);
  }
  /// Data *************************************************
  List<Course> courses = [];

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
    var resource = await repository.getCourses(paginationData: paginationData!);
    _coursesResponse(resource);
  }
}