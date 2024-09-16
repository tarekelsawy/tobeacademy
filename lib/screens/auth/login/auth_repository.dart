import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/utils/api.dart';


class AuthRepository extends BaseRepository{

  Future<Resource> studentLogin ({required Map data}){
    return request(callback: ()async{
      var response = await dio.post(Api.studentLogin,data: data);
      return Resource.success(data: User.fromMap(response.data));
    });
  }

  Future<Resource> socialLogin ({required Map data}){
    return request(callback: ()async{
      var response = await dio.post(Api.socialLogin,data: data);
      if((response.data as Map<String, dynamic>).containsKey('error')){
        return Resource.success(data: 'complete');
      }
      return Resource.success(data: User.fromMap(response.data));
    });
  }
}