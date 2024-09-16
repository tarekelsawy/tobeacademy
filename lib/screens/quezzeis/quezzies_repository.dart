import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/quiz.dart';
import 'package:icourseapp/utils/api.dart';

class QuezziesRepository extends BaseRepository {
  Future<Resource> getQuizes(
      {required int id, required bool isCourse, required bool isLesson}) {
    return request(callback: () async {
      var response = await dio.get(isCourse
          ? Api.courseQuizes(id.toString())
          : isLesson
              ? Api.lessonQuizies(id.toString())
              : Api.lectureQuizies(id.toString()));
      var quizzes = (response.data['quizzes'] as List)
          .map((e) => Quiz.fromMap(e))
          .toList();
      return Resource.success(data: quizzes);
    });
  }
}
