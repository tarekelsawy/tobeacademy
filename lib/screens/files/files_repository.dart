import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/file_model.dart';
import 'package:icourseapp/utils/api.dart';

class FileRepository extends BaseRepository {
  Future<Resource> getFiles({required int id}) {
    return request(callback: () async {
      var response = await dio.get(Api.getFiles(id.toString()));
      var files = (response.data['files'] as List)
          .map((e) => FileModelData.fromMap(e))
          .toList();
      return Resource.success(data: files);
    });
  }
}
