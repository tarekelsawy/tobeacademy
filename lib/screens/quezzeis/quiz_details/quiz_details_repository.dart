import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/quiz.dart';
import 'package:dio/dio.dart' as dioData;
import 'package:icourseapp/utils/api.dart';

class QuizDetailsRepository extends BaseRepository {
  Future<Resource> getQuestions({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getQuestions(id.toString()));
      if(response.data['quiz']['questions'] == null) return Resource.error();
      var questions = (response.data['quiz']['questions'] as List)
          .map((e) => Questions.fromMap(e))
          .toList();
      return Resource.success(data: questions);
    });
  }

  Future<Resource> getQuizStatus({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getQuizStatus(id.toString()));
      return Resource.success(data: response.data);
    });
  }

  Future<Resource> sendQuestions(
      {required int id, required List<Questions> questions}) {
    return request(callback: () async {
      Map<String, dynamic> map = {
        'quiz_id': id,
      };

      for (int index = 0; index < questions.length; index++) {
        map['questions[$index][question_id]'] = questions[index].id;
        map['questions[$index][choice]'] = questions[index].choice??'_________';
      }
      var response = await dio.post(Api.submitAnswers, queryParameters: map);

      return Resource.success(data: response.data['resault']['result']);
    });
  }
}
