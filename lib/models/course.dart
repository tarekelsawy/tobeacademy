import 'package:get/get.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/models/organization.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/screens/home/tabs/home_tab/home_tab_repository.dart';
import 'package:icourseapp/utils/date_time_util.dart';

class Course {
  final String? title,
      subtitle,
      description,
      price,
      image,
      video,
      youtubeVideoId;
  final int? id, categoryId,organizationId;
  final VideoType? introVideoCheck;
  final Accessibility? learnerAccessibility;
  final num? averageRating, lessonsCount, lecturesCount;
  final bool? isEnrollemnt;
  final Instructor? instructor;
  final List<Lesson>? lessons;

  Future<String> getCategory ()async{
   var res = await Get.find<HomeController>().repository.getCategories(id: organizationId!);
    if(res.isSuccess()){
      return (res.data as List<Category>).firstWhereOrNull((element) => element.id == categoryId)?.name??'';
    }
    return '';
  }

  Future<String> getOrganization ()async{
    var res = await HomeTabRepository().getOrganizations();
    if(res.isSuccess()){
      return (res.data as List<Organization>).firstWhereOrNull((element) => element.id == organizationId)?.name??'';
    }
    return '';
  }
  Course(
      {this.title,
      this.subtitle,
      this.isEnrollemnt,
      this.id,
      this.categoryId,
      this.organizationId,
      this.description,
      this.learnerAccessibility,
      this.introVideoCheck,
      this.lecturesCount,
      this.averageRating,
      this.price,
      this.lessonsCount,
      this.image,
      this.lessons,
      this.video,
      this.instructor,
      this.youtubeVideoId});

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      title: map['title'],
      id: map['id'],
      subtitle: map['subtitle'],
      lessonsCount: map['lessons_count'],
      description: map['description'],
      isEnrollemnt: map['is_enrollemnt'],
      price: map['price'],
      lecturesCount: map['lectures_count'],
      categoryId: map['category_id'],
      organizationId: map['organization_id'],
      image: map['image'],
      video: map['video'],
      introVideoCheck: VideoType.values.firstWhereOrNull(
          (element) => element.id == map['intro_video_check']),
      learnerAccessibility: Accessibility.values
              .firstWhereOrNull((e) => e.id == map['learner_accessibility'].toString()),
      averageRating: num.tryParse(map['average_rating'].toString()),
      youtubeVideoId: map['youtube_video_id'],
      instructor: map['instructor'] == null
          ? null
          : Instructor.fromMap(map['instructor']),
      lessons: map['lessons'] == null
          ? []
          : (map['lessons'] as List).map((e) => Lesson.fromMap(e)).toList(),
    );
  }
}

class Instructor {
  final int id;
  final String? firstName, lastName, professionalTitle, email, phoneNumber, aboutMe;

  Instructor(
      {required this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.aboutMe,
      this.professionalTitle});

  factory Instructor.fromMap(Map<String, dynamic> map) {
    print('dattdd --------> $map');
    return Instructor(
      id: map['id'],
      firstName: map['name'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      aboutMe: map['about_me'],
      lastName: map['last_name'],
      professionalTitle: map['professional_title'],
    );
  }
}

class Lesson {
  final int? id;
  final String? name,shortDescription;
  final bool? isEnrollemnt;
  final List<Lecture>? lectures;

  Lesson({ this.id,this.name, this.lectures, this.shortDescription, this.isEnrollemnt});

  factory Lesson.fromMap(Map<String, dynamic> map) {
    print('thumb_image -------------> ${map['thumb_image']}');
    return Lesson(
      id: map['id'],
      name: map['name'],
      isEnrollemnt: map['is_enrollemnt'],

      shortDescription: map['short_description'],
      lectures: map['lectures'] == null
          ? []
          : (map['lectures'] as List).map((e) => Lecture.fromMap(e)).toList(),
    );
  }
}

class Lecture {
  final String? title, filePath, urlPath, fileDuration, shortDescription, image, pdf, thumbImage, introVideo;
  final LectureType? type;
  final int? id;
  final num? fileDurationSecond;
  final Accessibility? lectureType;

  Lecture(
      {this.title,
      this.filePath,
      this.image,
      this.fileDurationSecond,
      this.id,
      this.pdf,
      this.thumbImage,
      this.introVideo,
      this.urlPath,
      this.fileDuration,
      this.lectureType,
      this.shortDescription,
      this.type});

  String get timing {
    int hours = fileDurationSecond! ~/ (60 * 60);
    String hrs = hours < 10? '0$hours' : '$hours';
    num remaining =  (fileDurationSecond!) - (hours * 60 * 60);
    int minutes = remaining ~/ 60;
    String mins = minutes < 10? '0$minutes' : '$minutes';
    remaining = remaining - (minutes * 60);
    String secs = remaining < 10? '0$remaining' : '$remaining';


    return '$hrs:$mins:$secs';
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    print('==========> ${map['lecture_type']}');
    return Lecture(
      title: map['title'],
      introVideo: map['course'] == null? null: map['course']['youtube_video_id'],
      id: map['id'],
      filePath: map['file_path'],
      thumbImage: map['thumb_image'],
      fileDurationSecond: map['file_duration_second'] ?? 0.0,
      type: LectureType.values
              .firstWhereOrNull((element) => element.name == map['type']) ??
          LectureType.video,
      lectureType: Accessibility.values
          .firstWhereOrNull((element) => element.id == (map['lecture_type'].toString())),
      shortDescription: map['short_description'],
      urlPath: map['url_path'],
      fileDuration: map['file_duration'],
    );
  }
}
enum Accessibility {
  free(id: '0'),
  paid(id: '1');

  final String id;
  const Accessibility({required this.id});
}

enum VideoType {
  normal(id: '0'),
  youtube(id: '1'),
  bunny(id: '2');

  final String id;
  const VideoType({required this.id});
}

enum LectureType {
  video(name: 'video'),
  youtube(name: 'youtube'),
  bunny(name: 'bunny');

  final String name;
  const LectureType({required this.name});
}
