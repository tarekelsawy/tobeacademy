import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/dio/dio_client.dart';
import 'package:icourseapp/helper/auth_helper.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/home/home_controller.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:icourseapp/utils/api.dart';
import '../helper/callback.dart';
import '../models/api/error_model.dart';
import '../models/api/resource.dart';

abstract class BaseRepository {
  /// Use [fetch,update,create,delete] ex fetchUserData(), updatePhoneNumber(), deletePost() || action name in unique cases .. and so on.

  //Controllers needs to disabled
  final List<StreamSubscription> _disposableList = [];

  //Dio getter
  Dio get dio {
    var dioClient = Get.find<DioClient>();
    return dioClient.dio;
  }

  //Paging
  final pageLimit = 10;

  //error rx
  var errorObservable = ErrorModel().obs;

  setError(ErrorModel? errorData) {
    errorObservable.value = errorData!;
    Get.closeAllSnackbars();
    Get.snackbar('', '',
        duration: const Duration(seconds: 2),
        backgroundColor: kRed,
        colorText: Colors.white,
        instantInit: false,
        titleText: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorData.message ?? 'Error',
              style: TextStyle(color: kWhite, fontFamily: kBold, fontSize: 16),
            ),
          ],
        ),
        snackPosition: SnackPosition.TOP);
  }

  Map<String, dynamic> baseHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  //Error Handler
  Resource handleError(e) {
    if (e is SocketException) {
      return Resource.error(
          errorData: ErrorModel(message: 'no_internet_connection'.tr));
    }
    if (e is DioException) {
      DioException error = e;
      DioExceptionType errorType = e.type;
      debugPrint('handleError DioError------ ${error.error}');
      if (errorType == DioExceptionType.unknown) {
        return Resource.error(
            errorData: ErrorModel(
                message: error.error is SocketException
                    ? 'no_internet_connection'.tr
                    : error.error is HttpException
                        ? 'no_internet_connection'.tr
                        : 'something_went_wrong'.tr + '${e.toString()}'));
      } else {
        if (error.response?.data is String) {
          return Resource.error(
              errorData: ErrorModel(message: error.response?.data));
        }
        var code = error.response?.data['code'];
        var msg = error.response?.data['message'];
        if ((msg as String).contains('اتصل بالدعم')) {
          Get.toNamed(Routes.contact);
        }
        if (code == 401 || error.response?.statusCode == 401) {
          Get.find<AuthHelper>().logout();
          Get.offAllNamed(Routes.home);
          return Resource.error(
              errorData: ErrorModel(code: code, message: msg));
        }
        return Resource.error(
            errorData: ErrorModel(message: error.response?.data['message']));
      }
    }
    return Resource.error(errorData: ErrorModel(message: e.toString()));
  }

  Resource baseHandleError(e) {
    return Resource.error(errorData: ErrorModel(message: e.toString()));
  }

  /// Request methods *******************************************

  //Generic request methods
  Future<Resource> request(
      {bool pushError = true, required RequestCallback callback}) async {
    try {
      Resource resource = await callback.call();
      if (resource.isSuccess()) debugPrint("DATA = ${resource.data}");
      if (resource.isError() && pushError && resource.errorData != null) {
        setError(resource.errorData);
      }
      return resource;
    } catch (e, stackTrace) {
      debugPrint("Error = $stackTrace");
      debugPrint("Error = $e");
      Resource resource;
      if (e is DioException) {
        resource = handleError(e);
      } else {
        resource = baseHandleError(e);
      }
      if (resource.isError() && pushError && resource.errorData != null) {
        setError(resource.errorData);
      }
      //Force Logout
      if (resource.errorData != null &&
          resource.errorData?.code != null &&
          resource.errorData?.code == 401) {
        await Get.find<AuthHelper>().logout();
        Get.offAllNamed(Routes.auth);
      }
      return resource;
    }
  }

  //Generic request real-time methods
  Stream<Resource> realTimeRequest(
      {bool pushError = true, required ListenerCallback callback}) async* {
    try {
      yield* callback.call();
    } catch (e, stackTrace) {
      debugPrint("Error $stackTrace"); // log error
      Resource resource = handleError(e);
      if (resource.isError() && pushError && resource.errorData != null) {
        setError(resource.errorData);
      }
      yield resource;
    }
  }

  ///close controllers
  void dispose() {
    errorObservable.close();
    for (StreamSubscription? controller in _disposableList) {
      if (controller != null) controller.cancel();
    }
  }

  ///Helper methods ****
  addDisposable(StreamSubscription subscription) =>
      _disposableList.add(subscription);

  /// shared methods
  Future<Resource> logout() {
    return request(callback: () async {
      await dio.post(Api.logout);
      return Resource.success(data: '');
    });
  }

  Future<Resource> deActivate() {
    return request(callback: () async {
      await dio.post(Api.deActivate);
      return Resource.success(data: '');
    });
  }
}
