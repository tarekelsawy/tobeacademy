class GeneralModel{
  final String? title, details, image, description;

  GeneralModel({ this.title,  this.details,  this.image, this.description});


  factory GeneralModel.fromMap(Map<String, dynamic> map) {
    return GeneralModel(
      title: map['title'],
      details: map['details'],
      description: map['description'],
      image: map['image'],
    );
  }
}