import 'package:icourseapp/base/base_repository.dart';
import 'package:icourseapp/utils/api.dart';

import '../../../models/api/resource.dart';

class ContactUsRepository extends BaseRepository{

  Future<Resource> getContact(){
    return request(callback: ()async{
      var response = await dio.get(Api.supportDetails);
      return Resource.success(data: response.data['support_details']);
    });
  }
}