import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/organization.dart';
import 'package:icourseapp/utils/api.dart';

import '../../../../models/course.dart';

class HomeTabRepository extends BaseRepository {
  Future<Resource> getOrganizations() {
    return request(callback: () async {
      var response = await dio.get(Api.getAllOrganizations);
      var organizations = (response.data['organizations'] as List)
          .map((e) => Organization.fromMap(e))
          .toList();
      return Resource.success(data: organizations);
    });
  }

  Future<Resource> getFeaturedCourses() {
    return request(callback: () async {
      var response =
          await dio.get(Api.featuredCourses, queryParameters: {'perPage': 10});
      var featured = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();

      return Resource.success(data: featured);
    });
  }

  Future<Resource> getNewCourses() {
    return request(callback: () async {
      var response =
          await dio.get(Api.newCourses, queryParameters: {'perPage': 10});
      var newCourse = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();
      return Resource.success(data: newCourse);
    });
  }
}
