class QuizArgs{
  final int modelId;
  final bool isCourse, isLesson;

  QuizArgs({required this.modelId, required this.isCourse, this.isLesson = false});
}