import 'package:icourseapp/base/base_repository.dart';

import '../../../../models/api/resource.dart';
import '../../../../models/sessions.dart';
import '../../../../utils/api.dart';

class LiveSessionsRepository extends BaseRepository{
  Future<Resource> getSessions() {
    return request(callback: () async {
      var response = await dio
          .get(Api.sessions);
      var courses = (response.data['sessions'] as List)
          .map((e) => Sessions.fromMap(e))
          .toList();

      return Resource.success(
          data: courses);
    });
  }

  Future<Resource> getTokenData ({required String channel}) {
    return request(callback: () async {
      var response = await dio
          .get('${Api.getToken}$channel');
      return Resource.success(
          data: response.data);
    });
  }
}