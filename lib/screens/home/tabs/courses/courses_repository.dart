import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/utils/api.dart';

class CoursesRepository extends BaseRepository{
  Future<Resource> getFeaturedCourses() {
    return request(callback: () async {
      var response = await dio.get(Api.featuredCourses,queryParameters: {
        'perPage': 10
      });
      var featured = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();

      return Resource.success(data: featured);
    });
  }

  Future<Resource> getNewCourses() {
    return request(callback: () async {
      var response = await dio.get(Api.newCourses,queryParameters: {
        'perPage': 10
      });
      var newCourse = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();
      return Resource.success(data: newCourse);
    });
  }


}