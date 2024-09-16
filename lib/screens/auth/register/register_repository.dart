import 'package:dio/dio.dart';
import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/utils/api.dart';


class RegisterRepository extends BaseRepository{

  Future<Resource> studentRegister ({required Map<String,dynamic> data}){
    return request(callback: ()async{
      print('To Map ------------> ${data}');
      var response = await dio.post(Api.register,data: FormData.fromMap(data));
      return Resource.success(data: User.fromMap(response.data));
    });
  }

  Future<Resource> updateData ({required Map<String,dynamic> data, required String id}){
    return request(callback: ()async{
      print('To Map ------------> ${data}');
       await dio.post(Api.updateStudent(id),data: FormData.fromMap(data));
      return Resource.success(data: '');
    });
  }

  Future<Resource> completeData ({required Map<String,dynamic> data}){
    return request(callback: ()async{
      print('To Map ------------> ${data}');
      var response = await dio.post(Api.socialRegister,data: FormData.fromMap(data));
      return Resource.success(data: User.fromMap(response.data));
    });
  }
}