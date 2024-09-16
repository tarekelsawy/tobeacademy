import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/category.dart';
import 'package:icourseapp/utils/api.dart';

import '../../models/organization.dart';

class OrganizationsRepository extends BaseRepository{

  Future<Resource> getOrganizations() {
    return request(callback: () async {
      var response = await dio.get(Api.getAllOrganizations);
      var organizations = (response.data['organizations'] as List)
          .map((e) => Category.fromMap(e))
          .toList();
      return Resource.success(data: organizations);
    });
  }
}