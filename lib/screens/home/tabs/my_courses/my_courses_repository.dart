import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/pagination_data.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/utils/api.dart';

class MyCoursesRepository extends BaseRepository {
  Future<Resource> getCourses({required PaginationData paginationData}) {
    return request(callback: () async {
      var response = await dio
          .get(Api.myCourses, queryParameters: {'page': paginationData.page});
      var courses = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();

      return Resource.success(
          data: courses, paginationData: PaginationData.fromMap(response.data));
    });
  }
}
