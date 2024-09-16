import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/utils/api.dart';


class EmailSendRepository extends BaseRepository{

  Future<Resource> forgotPassword ({required Map<String,dynamic> data}){
    return request(callback: ()async{
      var response = await dio.post(Api.forgetPassword,data: data);
      return Resource.success(data: response.data);
    });
  }

}