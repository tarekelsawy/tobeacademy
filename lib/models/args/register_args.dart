import 'package:icourseapp/screens/auth/register/register_controller.dart';

class RegisterArgs {
  final DataAction action;
  final String? provider, providerId, image, name, email, phone;

  RegisterArgs(
      {required this.action,
      this.provider,
      this.providerId,
      this.image,
      this.name,
      this.email,
      this.phone});
}
