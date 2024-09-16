import 'package:get/get.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/notifications.dart';
import 'package:icourseapp/screens/notification/notification_repository.dart';

class NotificationController extends SwipeableController{
  @override
  loadMore() {
    stopLoading();
  }

  @override
  onRefresh() {
    stopLoading();
  }

  @override
  NotificationRepository get repository => Get.put(NotificationRepository(),tag: tag);


  @override
  onCreate() {
    if(!isLoggedIn()) return;
    loading.value = true;
    _getNotification();
  }

  @override
  onDestroy() {
    Get.delete<NotificationRepository>(tag: tag);
  }


  /// Data ************************************************
  var notifications = <Notifications>[];


  /// logic **************************************************
  _notificationResponse(Resource resource){
    stopLoading();
    if(resource.isError()) return;
    notifications.addAll(resource.data);
    update();
  }
  /// Api Requests *******************************************
  _getNotification()async{
    var resource = await repository.getNotifications();
    _notificationResponse(resource);
  }
}