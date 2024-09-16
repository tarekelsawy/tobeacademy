import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:icourseapp/base/base_auth_controller.dart';
import 'package:icourseapp/models/api/resource.dart';
import 'package:icourseapp/models/args/register_args.dart';
import 'package:icourseapp/models/user.dart';
import 'package:icourseapp/navigation/app_routes.dart';
import 'package:icourseapp/screens/auth/login/auth_repository.dart';
import 'package:icourseapp/screens/auth/register/register_controller.dart';
import 'package:icourseapp/screens/auth/register/register_repository.dart';
import 'package:icourseapp/widgets/buttons/loading_button.dart';

import '../../../helper/social/apple_helper.dart';
import '../../../helper/social/google_helper.dart';

class AuthController extends BaseAuthController {
  @override
  AuthRepository get repository => Get.find();

  @override
  onCreate() {}

  /// Data *************************************************
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var socialLoader = false.obs;
  User? userProvider;

  /// listeners ********************************************
  onLogin() {
    if (formKey.currentState!.validate()) {
      btnController.start();
      _login(User(token: '', name: '', email: email.text));
    }
  }

  /// logic ************************************************
  _loginResponse(Resource resource) {
    btnController.stop();
    if (resource.isError()) return;
    saveClient(resource.data);
    Get.offAllNamed(Routes.home);
  }

  _socialResponse(Resource resource) {

    if (resource.isError()) {
      btnController.stop();
      return;
    }
    if (resource.data is String && resource.data == 'complete') {
      _completeAndContinue();
      return;
    }
    btnController.stop();
    saveClient(resource.data);
    Get.offAllNamed(Routes.home);
  }

  //onGoogleAuth() async {
   // socialLoader.value = true;
   // var user = await GoogleAuthHelper.signInWithGoogle();
  //  socialLoader.value = false;
   // debugPrint("========================= User =======================");
   // debugPrint("${user?.email.toString()} *//*/*/*/*/*/* ${user?.firstName.toString()}" );
  //  debugPrint("========================= User =======================");
  //  if(user == null) return;
  //  userProvider = user;
  //  btnController.start();
  //  _social();
//  }

  /*onAppleAuth() async {
    socialLoader.value = true;
    var user = await AppleAuthHelper.signInWithApple();
    socialLoader.value = false;
    if(user == null) return;
    userProvider = user;
    btnController.start();
    _social();
  }*/

  /// Api Requests ******************************************
  _login(User user) async {
    var resource = await repository.studentLogin(
        data: user.toLogin(password: password.text));
    _loginResponse(resource);
  }

  _social() async {
    var resource = await repository
        .socialLogin(data: {'provider': userProvider?.provider, 'provider_id': userProvider?.identifier});
    _socialResponse(resource);
  }


  Future<void> _completeAndContinue()async{
    var res = await RegisterRepository().completeData(data: {
      'first_name': (userProvider?.name??'').split(' ').isEmpty? '': (userProvider?.name??'').split(' ').first??'',
      'last_name': (userProvider?.name??'').split(' ').isEmpty? '': (userProvider?.name??'').split(' ').last??'',
      'email': userProvider?.email?? 'to.be.academy@${DateTime.now().millisecondsSinceEpoch}.com',
      'phone_number': userProvider?.phone?? '${DateTime.now().millisecondsSinceEpoch}',
      'provider': userProvider?.provider,
      'provider_id': userProvider?.identifier
    });
    btnController.stop();
    if(res.isSuccess()){

      saveClient(res.data);
      Get.offAllNamed(Routes.home);
    }

    return Future.value();
  }

}
