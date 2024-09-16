import 'package:dio/dio.dart';
import 'package:icourseapp/main.dart';


class DioClient {
  /// Data & constructor *************************************
  late Dio dio;
  String baseUrl =const String.fromEnvironment("BASE_URL_DASHBOARD");
  //String baseUrl = "https://www.dashboard.tobeacademy-mans.com/api/" ;

  DioClient({String? baseUrl}) {
    dio = Dio(BaseOptions(baseUrl: baseUrl??this.baseUrl));
    addInterceptor(dio);
  }

  void addInterceptor(Dio dio) {
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      options.headers.addAll(headers());
      handler.next(options);
    }, onResponse: (response, handler) {
      handler.resolve(response);
    }, onError: (DioException e, ErrorInterceptorHandler handler) {
      handler.next(e);
    }));
  }

  /// Add Headers *******************************************
  static Map<String, String> headers() {
    print('TOKEN ==============> ${pref.client?.token}');
    Map<String, String> map = {
      'Device-Id': deviceId,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'lang': LocalizationService.isRtl() ? 'ar' : 'en'
    };
    if (pref.client?.token != null) {
      map['Authorization'] = 'Bearer ${pref.client?.token}';
    }
    print('Headers ==============> $map');
    return map;
  }
}
