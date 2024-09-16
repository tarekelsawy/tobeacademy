import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/pagination_data.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/utils/api.dart';

class CategoriesCoursesRepository extends BaseRepository {
  Future<Resource> getCourses(
      {required int id, required int page, int? subjectId}) {
    return request(callback: () async {
      var map = {'page': page};

      if (subjectId != null) {
        map['subject_id'] = subjectId;
      }
      var response = await dio.get(
        //"https://www.dashboard.tobeacademy-mans.com/api/hcategory/${id.toString()}/courses",
          Api.getOrganizationCategoriesCourses(id.toString()),
          queryParameters: map);
      var courses = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();
      return Resource.success(
          data: courses, paginationData: PaginationData.fromMap(response.data));
    });
  }

  Future<Resource> getSubject() {
    return request(callback: () async {
      var response = await dio.get(Api.subject);
      var subjects = (response.data['subjects'] as List)
          .map((e) => Category.fromMap(e))
          .toList();
      return Resource.success(data: subjects);
    });
  }
}
