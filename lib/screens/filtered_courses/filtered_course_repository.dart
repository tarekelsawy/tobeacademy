import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/pagination_data.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/utils/api.dart';

class FilteredCourseRepository extends BaseRepository{
  Future<Resource> getFeaturedCourses({required PaginationData paginationData}) {
    return request(callback: () async {
      var response = await dio.get(Api.featuredCourses,queryParameters: {
        'page': paginationData.page
      });
      var featured = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();

      return Resource.success(data: featured, paginationData: PaginationData.fromMap(response.data));
    });
  }

  Future<Resource> getNewCourses({required PaginationData paginationData}) {
    return request(callback: () async {
      var response = await dio.get(Api.newCourses,queryParameters: {
        'page': paginationData.page
      });
      var newCourse = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();
      return Resource.success(data: newCourse, paginationData: PaginationData.fromMap(response.data));
    });
  }
}