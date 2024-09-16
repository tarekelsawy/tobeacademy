import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/pagination_data.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/utils/api.dart';

class LecturesRepository extends BaseRepository{
  Future<Resource> getLessons({required int id, required int page}) {
    return request(callback: () async {
      var response = await dio.get(
          Api.getCourseLessons(id),
          queryParameters: {'page': page});
      var lessons = (response.data['lessons']['data'] as List)
          .map((e) => Lesson.fromMap(e))
          .toList();
      return Resource.success(
          data: lessons, paginationData: PaginationData.fromMap(response.data['lessons']));
    });
  }
}