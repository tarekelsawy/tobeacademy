//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/utils/api.dart';

import '../../models/api/resource.dart';
import '../../models/category.dart';
import '../../models/chat_contacts.dart';

class HomeRepository extends BaseRepository {
  Future<Resource> getSecurity() {
    return request(callback: () async {
      var response = await dio.get(Api.securitySettings);
      var data = response.data;
      return Resource.success(data: data['key'] == '1');
    });
  }

  Future<Resource> getCourse({required String courseId}) {
    return request(
        pushError: false,
        callback: () async {
          var response = await dio.get(Api.getCourseById(courseId));
          var data = response.data['course'];
          return Resource.success(data: Course.fromMap(data));
        });
  }

  Future<Resource> getUser() {
    return request(
        pushError: false,
        callback: () async {
          var response = await dio.get(Api.user);
          Map<String,dynamic> data = {
            'profileData': response.data['profilData']
          };
          return Resource.success(data: User.fromMap(data));
        });
  }

  Future<Resource> sendFcm({String? token}) {
    return request(
        pushError: false,
        callback: () async {
          var fcm = token?? await FirebaseMessaging.instance.getToken();
          print('FCM ==========> $fcm');
          await dio.post(Api.sendFcm, data: {'fcm_token': fcm});
          return Resource.success(data: fcm);
        });
  }

  Future<Resource> getCategories({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getOrganizationCategories(id.toString()));
      var organizations = (response.data['organization']['categories'] as List)
          .map((e) => Category.fromMap(e))
          .toList();
      return Resource.success(data: organizations);
    });
  }

  Future<Resource> getContacts (){
    return request(callback: ()async{
      var response = await dio.get(Api.chatContacts);
      var contacts = (response.data['contacts'] as List).map((e) => ChatContacts.fromMap(e)).toList();
      var count = 0;
       await Future.wait(contacts.map((e) async{
        count += e.unreadMessagesCount;
      }));
      return Resource.success(data: count);
    });
  }
}
