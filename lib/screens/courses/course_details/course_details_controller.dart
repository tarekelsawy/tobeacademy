import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/course_review.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/courses/course_details/course_details_repository.dart';
import 'package:icourseapp/screens/player/player_controller.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';
import 'package:icourseapp/widgets/rate.dart';

class CourseDetailsController extends BaseController {
  @override
  CourseDetailsRepository get repository => Get.put(CourseDetailsRepository());

  @override
  onCreate() {
    _getCourse();
    loadReviews.value = true;
    _getReviews();
  }

  @override
  onDestroy() {
    Get.delete<CourseDetailsRepository>();
  }

  /// Data ****************************************************
  Course course = Get.arguments;
  List<CourseReview> reviews = [];
  var loadReviews = false.obs;
  var hasDiscount = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController code = TextEditingController();
  var isReview = false.obs;

  /// listeners ***********************************************
  /*stopVideo(){
    if(Get.isRegistered<PlayerController>(tag: course.youtubeVideoId??'')){
      Get.find<PlayerController>(tag: course.youtubeVideoId!).videoController.pause();
    }
  }*/
  onShowLectures() {
    //stopVideo();
    Get.toNamed(Routes.lectures, arguments: course);
  }

  onToggleCodeDiscount() => hasDiscount.value = !hasDiscount.value;

  onSendRequest() {
    if (!isLoggedInWithSheet()) return;
    btnController.start();
    if (hasDiscount.value) {
      if (formKey.currentState!.validate()) {
        _sendDiscountCode();
      }
    } else {
      if (code.text.trim().isNotEmpty) {
        _sendRequestWithPurchase();
      } else {
        _sendRequest();
      }
    }
  }

  /// Api Requests *********************************************
  _getReviews() async {
    var resource = await repository.getCourseReview(courseId: course.id!);
    loadReviews.value = false;
    if (isLoggedIn()) {
      _rateCheckIfUserReview();
    }
    if (resource.isSuccess()) {
      reviews = resource.data;
      update();
    }
  }

  _getCourse() async {
    var resource = await repository.getCourseId(courseId: course.id!);
    if (resource.isSuccess()) {
      course = resource.data;
      update();
    }
  }

  _rateCheckIfUserReview() async {
    var resource =
        await repository.checkIfUserReview(courseId: course.id!.toString());
    if (resource.isSuccess()) {
      isReview.value = resource.data;
    }
  }

  _sendRequest() async {
    var resource =
        await repository.sendRequest(courseId: course.id!.toString());
    btnController.stop();
    if (resource.isSuccess()) {
      showSuccessMessage(resource.data);
    }
  }

  _sendRequestWithPurchase() async {
    var resource = await repository.sendRequestWithCode(
        courseId: course.id!.toString(), code: code.text);
    btnController.stop();
    if (resource.isSuccess()) {
      showSuccessMessage(resource.data);
    }
  }

  _sendDiscountCode() async {
    var resource = await repository.discountCode(
        courseId: course.id!.toString(), code: code.text);
    btnController.stop();
    if (resource.isSuccess()) {
      showSuccessMessage(resource.data);
    }
  }
}
