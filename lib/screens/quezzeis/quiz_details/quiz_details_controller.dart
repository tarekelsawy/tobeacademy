import 'dart:async';

import 'package:get/get.dart';
import 'package:icourseapp/base/swipeable_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/quiz.dart';
import 'package:icourseapp/screens/quezzeis/quiz_details/quiz_details_repository.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';

class QuizDetailsController extends SwipeableController {
  @override
  QuizDetailsRepository get repository =>
      Get.put(QuizDetailsRepository(), tag: tag);

  @override
  loadMore() {}

  @override
  onRefresh() {
    stopLoading();
  }

  @override
  onDestroy() {
    Get.delete<QuizDetailsRepository>(tag: tag);
    _timer?.cancel();
    sub?.cancel();
  }

  @override
  onCreate() {
    paginationEnabled(false);
    loading.value = true;
    _getQuestions();
  }

  /// Data ***************************************************
  Quiz quiz = Get.arguments;
  var questions = <Questions>[];
  var sendingQuestions = <Questions>[];
  Timer? _timer; // Down from $val to 0 seconds
  var seconds = 0.obs;
  var isFinished = false.obs;
  StreamSubscription? sub;
  var score = ''.obs;
  var standard = ''.obs;
  num get waitingTimer => quiz.quizTimeMinute;
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  /// listeners ********************************************
  onSelectedQuestion(Questions questions) {
    var indexOf =
        sendingQuestions.indexWhere((element) => element.id == questions.id);
    if (indexOf != -1) {
      sendingQuestions[indexOf] = questions;
    }
    update();
  }

  Future<void> onSubmit() async {
    await _sendQuestions();

    return Future.value();
  }

  startTimer() {
    seconds.value = (waitingTimer.toInt() * 60); // init
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds--;
      }
    });
  }

  _listenToTimerChange() {
    sub = seconds.listen((seconds) {
      if (seconds == 0) {
        _timer?.cancel();
        sub?.cancel();
        _sendQuestions();
      }
    });
  }

  /// logic ************************************************
  _responseQuestions(Resource resource) {
    stopLoading();
    if (resource.isError()) return;
    questions = resource.data;
    sendingQuestions = resource.data;
    _getQuizStatus();
    update();
  }

  /// Api Requests ******************************************
  _getQuestions() async {
    var resource = await repository.getQuestions(id: quiz.id);
    _responseQuestions(resource);
  }

  Future<void> _sendQuestions() async {
    btnController.start();
    var res = await repository.sendQuestions(
        id: quiz.id, questions: sendingQuestions);

    if (res.isSuccess()) {
      _getQuizStatus();
      return Future.value();
    }
    btnController.stop();

    return Future.value();
  }

  _getQuizStatus() async {
    var resource = await repository.getQuizStatus(id: quiz.id);
    try {
      btnController.stop();
    } catch (e) {}
    if (resource.isSuccess()) {

      isFinished.value = resource.data['status'];
      if (isFinished.value) {
        score.value = resource.data['quiz']['result'].toString();
        standard.value = resource.data['quiz']['standard'].toString();
        List<dynamic> answers = resource.data['quiz']['answers'];
        for (var answer in answers) {
          var index = questions
              .indexWhere((element) => element.id == answer['question']['id']);
          if (index != -1) {
            questions[index] = Questions.fromAnswers(answer, questions[index]);
            sendingQuestions[index] =
                Questions.fromAnswers(answer, questions[index]);
          }
        }
        update();
        stopLoading();
        showConfirmationDialog(
            barrierDismissible: false,
            body: 'النتيجه',
            okCallback: () {},
            okText: 'مراجعه الاجابات',
            showCancel: false,
            score: num.parse(score.value),
            standard: num.parse(standard.value),
            percentage: (num.parse(score.value) / num.parse(standard.value)));
        return;
      }
      startTimer();
      _listenToTimerChange();
    } else {
      stopLoading();
    }
  }
}
