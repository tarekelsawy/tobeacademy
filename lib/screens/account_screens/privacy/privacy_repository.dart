import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/general_model.dart';
import 'package:icourseapp/utils/api.dart';

class PrivacyRepository extends BaseRepository{
  Future<Resource> getPrivacy (){
    return request(callback: ()async{
      var response = await dio.get(Api.terms);
      var blogs = (response.data['terms'] as List).map((e) => GeneralModel.fromMap(e)).toList();
      return Resource.success(data: blogs);
    });
  }
}