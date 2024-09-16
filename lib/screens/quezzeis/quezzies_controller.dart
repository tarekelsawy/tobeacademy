import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/quiz.dart';
import 'package:icourseapp/models/quiz_args.dart';
import 'package:icourseapp/screens/quezzeis/quezzies_repository.dart';

import '../../navigation/app_routes.dart';

class QuezziesController extends SwipeableController {
  @override
  QuezziesRepository get repository => Get.find(tag: tag);

  @override
  loadMore() {}

  @override
  onRefresh() {
    quizzes.clear();
    _getQuizzes();
  }

  @override
  onCreate() {
    paginationEnabled(false);
    loading.value = true;
    _getQuizzes();
  }

  /// Data ******************************************
  var quizzes = <Quiz>[];
  QuizArgs args = Get.arguments;

  /// listeners **********************************
  onNavigateToQuizDetails(Quiz quiz) {
    Get.toNamed(Routes.quizDetails, arguments: quiz);
  }

  /// logic **************************************
  _quizResponse(Resource resource) {
    stopLoading();
    if (resource.isError()) return;
    quizzes = resource.data;
    update();
  }

  /// Api requests *******************************
  _getQuizzes() async {
    var resource =
        await repository.getQuizes(id: args.modelId, isCourse: args.isCourse, isLesson: args.isLesson);
    _quizResponse(resource);
  }
}
