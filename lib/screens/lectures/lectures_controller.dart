import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/screens/lectures/lectures_repository.dart';

import '../player/player_controller.dart';

class LecturesController extends SwipeableController{

  @override
   LecturesRepository get repository => Get.find(tag: tag);

  @override
  onCreate() {
    Get.put(PlayerController());
    loading.value = true;
    _getLessons();
  }

  @override
  void onClose() {
    stopVideo();
  }

  @override
  loadMore() {
    if(loading.value || paginationData!.isLastPage){
      stopLoading();
      return;
    }
    _getLessons();
  }

  @override
  onRefresh() {
    resetPagination();
    lessons.clear();
    _getLessons();
  }

  stopVideo() {
    if(lessons.isNotEmpty && lessons.first.lectures!.isNotEmpty && lessons.first.lectures!.first.introVideo !=null) return;
    if (Get.isRegistered<PlayerController>(tag: lessons.first.lectures!.first.introVideo)) {
      //Get.find<PlayerController>(tag: lessons.first.lectures!.first.introVideo).videoController.pause();
      Get.delete<PlayerController>();
    }
  }

  /// Data ********************************************************
  var lessons = <Lesson>[];
  Course course = Get.arguments;


  /// listeners **************************************************
  onLecture(Lecture lecture){

  }
  /// logic *******************************************************
  _responseLessons(Resource resource){
    stopLoading();
    if(resource.isError()) return;
    lessons.addAll(resource.data);
    paginationData = resource.paginationData;
    setNextPage();
    update();
  }
  /// Api Requests ************************************************
  _getLessons()async{
    var resource = await repository.getLessons(id: course.id!, page: paginationData?.page??0);
    _responseLessons(resource);
  }
}