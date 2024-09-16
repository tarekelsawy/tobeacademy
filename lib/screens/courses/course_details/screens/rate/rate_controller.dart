import 'package:get/get.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/course_review.dart';
import 'package:icourseapp/screens/courses/course_details/screens/rate/rat_repository.dart';

import '../../../../../widgets/rate.dart';

class RateController extends SwipeableController {
  /// Data **********************************************************************
  var reviews = <CourseReview>[];
  Course course = Get.arguments;
  /// Lifecycle *********************************************************************
  @override
  onCreate() async {
    loading.value = true;
    _getReviews();
  }

  @override
  loadMore() {
   if(loading.value || paginationData!.isLastPage){
     stopLoading();
   }
   _getReviews();
  }

  @override
  onRefresh() {
   resetPagination();
   reviews.clear();
   _getReviews();
  }

  @override
  RateRepository get repository => Get.find(tag: tag);

  /// Listeners ****************************************************************

  onRateUsers() {
    Get.bottomSheet(
        RateUserSheet(
          title: 'تقييم الكورس',
          subTitle: 'ما هو تقييمك للكورس',
          onConfirmRate: (String comment, int rate) async =>
          await _rateCourse(comment: comment, rate: rate.toString()),
        ),
        isScrollControlled: true);
  }

  /// Logic ****************************************************************

  /// Api Requests ****************************************************************
  /// Api Requests *********************************************
  _getReviews() async {
    var resource = await repository.getCourseReview(courseId: course.id!, paginationData: paginationData!);
    stopLoading();
    if (resource.isSuccess()) {
      reviews.addAll(resource.data);
      paginationData = resource.paginationData;
      setNextPage();
      update();
    }
  }

  _rateCourse({required String comment, required String rate}) async {
    var resource = await repository.addReview(
        courseId: course.id!, comment: comment, rate: rate);
    if (resource.isSuccess()) {
      showSuccessMessage('تم إضافه تقييمك');
      _getReviews();
    }
  }
}
