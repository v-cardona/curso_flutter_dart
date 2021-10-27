import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      // generar el id token para enviar al backend
      final googleKey = await account?.authentication;

      // llamar servicio backend con el token
      return account;
    } catch (e) {
      return null;
    }
  }

  static Future<GoogleSignInAccount?> signOutWithGoogle() async {
    try {
      final account = await _googleSignIn.signOut();
      return account;
    } catch (e) {
      return null;
    }
  }
}
