class Report{
  final List<Enrollment> enrollements;
  final List<Attendance> attendance;

  Report({required this.enrollements, required this.attendance});


  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      enrollements: (map['enrollements'] as List).map((e) => Enrollment.fromMap(e)).toList(),
      attendance: (map['attendance'] as List).map((e) => Attendance.fromMap(e)).toList(),
    );
  }
}

class ReportSection{
  final String name;
  final DateTime createdAt;

  ReportSection({required this.name, required this.createdAt});


  factory ReportSection.fromMap(Map<String, dynamic>? map) {
    return ReportSection(
      name: map?['name']??'',
      createdAt: DateTime.tryParse(map?['created_at'].toString()??'')??DateTime.now(),
    );
  }
}

class Enrollment{
  final String? startDate, endDate, courseName;
  final List<ReportSection>? enrollmentSections;

  Enrollment({ this.startDate,  this.endDate,  this.courseName,  this.enrollmentSections});


  factory Enrollment.fromMap(Map<String, dynamic> map) {
    return Enrollment(
      startDate: map['start_date'],
      endDate: map['end_date'],
      courseName: map['course'] == null? null: map['course']['title'],
      enrollmentSections: (map['enrollment_sections'] as List).map((e) => ReportSection.fromMap(e['section'])).toList(),
    );
  }
}

class Attendance{
  final String? attendanceDate, className, categoryName, subjectName;

  Attendance({ this.attendanceDate,  this.className,  this.categoryName,  this.subjectName});


  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      attendanceDate: map['attendance_date'],
      className: map['class'] == null? null: map['class']['name'],
      categoryName: map['class'] == null? null: map['class']['category'] == null? null: map['class']['category']['name'],
      subjectName: map['class'] == null? null:  map['class']['subject'] == null? null: map['class']['subject']['name'],
    );
  }
}