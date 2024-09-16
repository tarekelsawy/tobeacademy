import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/chat_contacts.dart';
import 'package:icourseapp/utils/api.dart';

import '../../../../models/api/resource.dart';


class ChatRepository extends BaseRepository{

  Future<Resource> getContacts (){
    return request(callback: ()async{
      var response = await dio.get(Api.chatContacts);
      var contacts = (response.data['contacts'] as List).map((e) => ChatContacts.fromMap(e)).toList();
      return Resource.success(data: contacts);
    });
  }
}