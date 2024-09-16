import 'package:get/get.dart';
import 'package:icourseapp/base/base_controller.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/sessions.dart';
import 'package:icourseapp/screens/home/tabs/live_sessions/live.dart';
import 'package:icourseapp/screens/home/tabs/live_sessions/live_sessions_repository.dart';

import '../../../../models/api/resource.dart';

class LiveSessionsController extends SwipeableController<LiveSessionsRepository>{
  @override
  LiveSessionsRepository get repository => Get.put(LiveSessionsRepository());


  /// listeners *******************************************
  onCourseNavigate(Sessions sessions){
    Get.to(()=> LiveSessions(), arguments: sessions);
  }
  /// Data *************************************************
  List<Sessions> sessions = [];

  /// logic ***************************************
  _sessionsResponse(Resource resource){
    stopLoading();
    if(resource.isError()) return;
    sessions = resource.data;
    update();
  }
  /// Api Requests ***************************************
  _getSessions()async{
    var resource = await repository.getSessions();
    _sessionsResponse(resource);
  }

  @override
  onCreate() {
    if(!isLoggedIn()) return;
    loading.value = true;
    _getSessions();
  }

  @override
  loadMore() {
    stopLoading();
  }

  @override
  onRefresh() {
    sessions.clear();
    _getSessions();
  }
}