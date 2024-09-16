class Organization{
  final int id;
  final String name;
  final String? image;
  final String? courseCount;

  Organization({required this.id, required this.name,  this.image, this.courseCount});


  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      courseCount: map['course_count'] == null ? null : map['course_count'].toString(),
    );
  }
}