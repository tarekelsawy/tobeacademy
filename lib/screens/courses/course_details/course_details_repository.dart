import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/models/course_review.dart';
import 'package:icourseapp/utils/api.dart';

class CourseDetailsRepository extends BaseRepository {
  Future<Resource> getCourseReview({required int courseId}) {
    return request(callback: () async {
      var response = await dio
          .get(Api.getCourseReview(courseId), queryParameters: {'perPage': 5});
      var reviews = (response.data['data'] as List)
          .map((e) => CourseReview.fromMap(e))
          .toList();
      return Resource.success(data: reviews);
    });
  }

  Future<Resource> getCourseId({required int courseId}) {
    return request(callback: () async {
      var response = await dio
          .get(Api.getCourseById(courseId.toString()));
      var course = Course.fromMap(response.data['course']);
      return Resource.success(data: course);
    });
  }



  Future<Resource> checkIfUserReview({required String courseId}) {
    return request(callback: () async {
      var response = await dio.get(Api.checkIfUserReview(courseId));
      return Resource.success(data: response.data['has_review'] ?? false);
    });
  }

  Future<Resource> sendRequest({required String courseId, String? sectionId}) {
    return request(callback: () async {
      Map data = {
        'course_id': courseId,
      };
      if (sectionId != null) {
        data['section_id'] = sectionId;
      }
      var response = await dio.post(Api.sendRequest, data: data);
      return Resource.success(data: response.data['message']);
    });
  }

  Future<Resource> sendRequestWithCode(
      {required String courseId, required String code, String? sectionId}) {
    return request(callback: () async {
      Map data = {
        'course_id': courseId,
        'coupon_code': code,
      };
      if (sectionId != null) {
        data['section_id'] = sectionId;
      }
      var response = await dio.post(Api.sendRequestWithCode,
          data: data);
      return Resource.success(data: response.data['message']);
    });
  }

  Future<Resource> discountCode(
      {required String courseId, required String code}) {
    return request(callback: () async {
      var response = await dio.post(Api.purchaseRequestWithDiscountCode,
          data: {'course_id': courseId, 'coupon_code': code});
      return Resource.success(data: response.data['message']);
    });
  }
}
