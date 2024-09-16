import 'package:dio/dio.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/utils/api.dart';


class ResetPasswordRepository extends BaseRepository{

  Future<Resource> newPassword ({required Map data}){
    return request(callback: ()async{
      var response = await dio.post(Api.newPassword,data: data);
      return Resource.success(data: response.data);
    });
  }
}