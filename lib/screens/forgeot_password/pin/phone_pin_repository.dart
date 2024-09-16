
import '../../../../../base/base_repository.dart';
import '../../../../../models/api/resource.dart';
import '../../../../../utils/api.dart';

class PhonePinRepository extends BaseRepository {

  Future<Resource> validateOtp ({required Map data}){
    return request(callback: ()async{
      var response = await dio.post(Api.checkOtp,data: data);
      return Resource.success(data: response.data);
    });
  }



}
