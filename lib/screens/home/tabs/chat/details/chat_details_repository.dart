import 'package:dio/dio.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/chat_item.dart';

import '../../../../../models/api/resource.dart';
import '../../../../../utils/api.dart';

class ChatDetailsRepository extends BaseRepository {
  Future<Resource> getOldMessages({required String id}) {
    return request(callback: () async {
      var response = await dio.get(Api.messages(id));
      var messages = (response.data['chat'] as List)
          .map((e) => ChatItem.fromMap(e))
          .toList();
      return Resource.success(data: messages);
    });
  }

  Future<Resource> sendMessages({required String id, required String message}) {
    return request(callback: () async {
      await dio.post(Api.messages(id), data: {'message': message});
      return Resource.success(data: 'Done');
    });
  }

  Future<Resource> sendMessageWithFile({required String id, required MultipartFile file, required String baseName}) {
    return request(callback: () async {
     var res = await dio.post(Api.sendMessageFile(id), data: FormData.fromMap({
        'caption': baseName,
        'file': file
      }));
      var message = ChatItem.fromMap(res.data['newMessageData']);
      return Resource.success(data: message);
    });
  }

  Future<Resource> markRead({required String id}) {

    return request(callback: () async {
      await dio.post(Api.markReadMessages(id));
      return Resource.success(data: 'Done');
    });
  }
}
