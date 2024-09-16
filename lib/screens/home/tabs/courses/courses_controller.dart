import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/tabs/courses/courses_repository.dart';

class CoursesController extends BaseController {
  @override
  injectRepository() {
    Get.put(CoursesRepository());
  }

  @override
  onDestroy() {
    Get.delete<CoursesRepository>();
  }

  var loadNewCourse = false.obs;

  @override
  onCreate() {
    loading.value = true;
    loadNewCourse.value = true;
    _getFeaturedCourses();
    _getNewCourses();
  }

  @override
  CoursesRepository get repository => Get.find();

  /// listeners *******************************************
  onCourseNavigate(Course course) {
    Get.toNamed(Routes.courseDetails, arguments: course);
  }

  /// Data *************************************************
  List<Course> featuredCourses = [];
  List<Course> newCourses = [];

  /// logic ***************************************
  _coursesResponse(Resource resource) {
    stopLoading();
    if (resource.isError()) return;
    featuredCourses = resource.data;
    update();
  }

  _coursesNewResponse(Resource resource) {
    loadNewCourse.value = false;
    if (resource.isError()) return;
    newCourses = resource.data;
    update();
  }

  /// Api Requests ***************************************
  _getFeaturedCourses() async {
    var resource = await repository.getFeaturedCourses();
    _coursesResponse(resource);
  }

  _getNewCourses() async {
    var resource = await repository.getNewCourses();
    _coursesNewResponse(resource);
  }
}
