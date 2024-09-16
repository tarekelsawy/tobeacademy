import 'package:icourseapp/models/user.dart';

class CourseReview {
  final String?  comment;
  final num rating;
  final DateTime updatedAt;
  final User? user;

  CourseReview({required this.rating, required this.comment, required this.updatedAt, required this.user});


  factory CourseReview.fromMap(Map<String, dynamic> map) {
    print('CourseReview ------------> ${map}');
    return CourseReview(
      rating: num.tryParse(map['rating'].toString()??'')??0,
      comment: map['comment'],
      updatedAt: DateTime.parse(map['updated_at']),
      user: map['student'] == null? null:User.fromStudent(map['student']),
    );
  }
}