import 'package:dio/dio.dart';

class User {
  final int? id;
   String? token, name, email, identifier, provider, classes;
  final String? image, phone, firstName, lastName, address, points;
   MultipartFile? avater;

  User(
      {required this.token,
      required this.name,
      required this.email,
      this.firstName,
      this.lastName,
      this.identifier,
      this.provider,
      this.classes,
      this.points,
      this.address,
      this.avater,
      this.id,
      this.image,
      this.phone});

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'profileData': {
        'fullName': name,
        'id': id,
        'email': email,
        'class': classes,
        'image': image,
        'phone_number': phone,
        'points': points,
      }
    };
  }

  Map<String, dynamic> toRegister({required String password}) {
    Map<String,dynamic> map = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'class': classes,
      'password': password
    };
    if(phone != null){
      map['phone_number'] = phone;
    }

    if(address != null){
      map['address'] = address;
    }

    if(avater != null){
      map['avater'] = avater;
    }

    return map;
  }

  Map<String, dynamic> toLogin({required String password}) {
    return {
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'],
      name: map['profileData']['fullName'],
      id: map['profileData']['id'],
      email: map['profileData']['email'],
      classes: map['profileData']['class'],
      image: map['profileData']['image'],
      phone: map['profileData']['phone_number'],
      points: map['profileData']['points'].toString(),
    );
  }

  factory User.fromStudent(Map<String, dynamic> map) {
    return User(
      name: map['fullName'],
      image: map['user']['image'],
      token: '',
      email: '',
    );
  }
}
