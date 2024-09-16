import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/pagination_data.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course_review.dart';
import 'package:icourseapp/utils/api.dart';

class RateRepository extends BaseRepository{
  Future<Resource> getCourseReview({required int courseId, required PaginationData paginationData}) {
    return request(callback: () async {
      var response = await dio
          .get(Api.getCourseReview(courseId), queryParameters: {'page': paginationData.page});
      var reviews = (response.data['data'] as List)
          .map((e) => CourseReview.fromMap(e))
          .toList();
      return Resource.success(data: reviews, paginationData: PaginationData.fromMap(response.data));
    });
  }

  Future<Resource> addReview(
      {required int courseId, required String comment, required String rate}) {
    return request(callback: () async {
      await dio.post(Api.addReview, data: {
        'course_id': courseId.toString(),
        'rating': rate,
        'comment': comment
      });
      return Resource.success(data: 'Done');
    });
  }
}