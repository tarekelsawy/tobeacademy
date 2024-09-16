import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/announcement.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/utils/api.dart';

class AnnouncementRepository extends BaseRepository {
  Future<Resource> getAnnouncement({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getAnnouncement(id.toString()));
      var announcements = (response.data['announcements'] as List)
          .map((e) => Announcement.fromMap(e))
          .toList();
      return Resource.success(data: announcements);
    });
  }
}
