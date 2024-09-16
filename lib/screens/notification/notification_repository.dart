import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/notifications.dart';
import 'package:icourseapp/utils/api.dart';

import '../../models/api/resource.dart';

class NotificationRepository extends BaseRepository{
  Future<Resource> getNotifications(){
    return request(callback: ()async{
      var response = await dio.get(Api.notification);
      var notifications = (response.data['notifications'] as List).map((e) => Notifications.fromMap(e)).toList();
      return Resource.success(data: notifications);
    });
  }
}