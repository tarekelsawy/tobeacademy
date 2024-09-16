import 'package:dio/dio.dart';
import 'package:icourseapp/base/base_repository.dart';
import '../../models/api/resource.dart';

class VideoPlayerRepository extends BaseRepository {
  Future<Resource> getVideoResolution({required String videoId}) {
    return request(
        pushError: false,
        callback: () async {
          var dio =  Dio(BaseOptions(
              baseUrl:
                  String.fromEnvironment("BASE_URL_VIDEO"),
                  //"https://video.bunnycdn.com/library/160514/videos/",
                  
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'AccessKey': String.fromEnvironment("ACCESS_KEY")
              }));
          dio.interceptors
              .add(LogInterceptor(responseBody: true, requestBody: true));
          var response = await dio.get(videoId);

          String data = response.data['availableResolutions'];
          var resolution = data.replaceAll('p', '').trim();
          var numbers = resolution.split(',').map((e) => num.parse(e)).toList();
          return Resource.success(data: numbers);
        });
  }
}
