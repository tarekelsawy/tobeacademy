class Category {
  final int id;
  final String name;
  final String? image;
  final String? courseCount;

  Category({required this.id, required this.name,  this.image, this.courseCount});


  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      courseCount: map['course_count'] == null? null: map['course_count'].toString(),
    );
  }
}