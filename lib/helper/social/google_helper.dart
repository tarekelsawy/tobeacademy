/*import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user.dart';

class GoogleAuthHelper {
  ///Methods & Config
  static Future<User?> signInWithGoogle() async {
   try{
     // Trigger the authentication flow
     await signOut();
     final GoogleSignInAccount? googleUser = await GoogleSignIn(
       scopes: ['email', 'profile'],
     ).signIn();
     if (googleUser == null) return null;

     // Obtain the auth details from the request
     final GoogleSignInAuthentication googleAuth =
     await googleUser.authentication;

     print('==============> ${googleAuth.accessToken}');

     return User(
         name: googleUser.displayName,
         email: googleUser.email,
         image: googleUser.photoUrl,
         provider: 'google',
         token: '',
         identifier: googleUser.id
     );
   }catch(e){
     return null;
   }
  }

  static Future<GoogleSignInAccount?> signOut() async {
    return await GoogleSignIn().signOut();
  }
}*/
