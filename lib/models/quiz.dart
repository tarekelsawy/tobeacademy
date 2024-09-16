class Quiz{
  final int id;
  final bool isRequired;
  final String title,createdAt;
  final num quizTimeMinute;

  Quiz({required this.id, required this.isRequired, required this.title, required this.quizTimeMinute, required this.createdAt});


  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      isRequired: map['is_required'] == '1',
      title: map['title'],
      createdAt: map['created_at']??'',
      quizTimeMinute: num.tryParse(map['quiz_time_minute'].toString())??0,
    );
  }
}

class Questions {
  final int? id;
  final num? degree;
  final String? question,choice, rightChoice, image;
  final List<String>? choices;

  List<Questions>? values;

  Questions({ this.id,  this.question,  this.choices, this.choice, this.rightChoice, this.degree, this.image});

  Map<String, dynamic> toMap() {
    return {
      'question_id': id,
      'choice': choice??'',
    };
  }


  bool get isCorrect => rightChoice?.compareTo(choice??'') == 0;

  factory Questions.fromAnswers(Map<String, dynamic> map, Questions questions,) {
    return Questions(
      question: questions.question,
      choices: questions.choices,
      degree: questions.degree,
      image: questions.image,
      id: map['id'],
      choice: map['choice'],
      rightChoice: map['question'] == null? '-----': map['question']['right_choice'],
    );
  }

  factory Questions.fromMap(Map<String, dynamic> map) {
    return Questions(
      id: map['id'],
      question: map['header'],
      image: map['image'],
      degree: map['degree'],
      choices: map['choices'] == null? []: (map['choices'] as List).map((e) => e.toString()).toList(),
    );
  }
}