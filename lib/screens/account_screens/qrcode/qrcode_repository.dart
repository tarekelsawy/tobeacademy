import 'package:icourseapp/base/base_repository.dart';

import '../../../models/api/resource.dart';
import '../../../utils/api.dart';

class QRCodeRepository extends BaseRepository{
  Future<Resource> sendCode ({required String code}){
    return request(pushError: false ,callback: ()async{
      var response = await dio.post(Api.qrCode, data: {
        'class_uuid': code
      });
      return Resource.success(data: 'Done');
    });
  }
}