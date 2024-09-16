import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/utils/api.dart';

class CategoriesRepository extends BaseRepository{
  Future<Resource> getCategories({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getOrganizationCategories(id.toString()));
      var organizations = (response.data['organization']['categories'] as List)
          .map((e) => Category.fromMap(e))
          .toList();
      return Resource.success(data: organizations);
    });
  }
}