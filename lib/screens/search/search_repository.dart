import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/pagination_data.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/course.dart';
import 'package:icourseapp/utils/api.dart';

class SearchRepository extends BaseRepository {
  Future<Resource> getSearch({required PaginationData paginationData, required String searchQuery}) {
    return request(callback: () async {
      var response = await dio
          .get(Api.getSearch, queryParameters: {'page': paginationData.page,'search_query':searchQuery});
      var courses = (response.data['data'] as List)
          .map((e) => Course.fromMap(e))
          .toList();

      return Resource.success(
          data: courses, paginationData: PaginationData.fromMap(response.data));
    });
  }
}
