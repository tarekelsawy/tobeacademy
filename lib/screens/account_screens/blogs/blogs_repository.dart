import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/general_model.dart';
import 'package:icourseapp/utils/api.dart';

class BlogsRepository extends BaseRepository{
  Future<Resource> getBlogs (){
    return request(callback: ()async{
      var response = await dio.get(Api.blogs);
      var blogs = (response.data['blogs'] as List).map((e) => GeneralModel.fromMap(e)).toList();
      return Resource.success(data: blogs);
    });
  }
}