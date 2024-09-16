import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/utils/api.dart';

class SubCategoriesRepository extends BaseRepository{
  Future<Resource> getCategories({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getSubCategories(id.toString()));
      var organizations = (response.data['category']['subcategories'] as List)
          .map((e) => Category.fromMap(e))
          .toList();
      return Resource.success(data: organizations);
    });
  }
}