import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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
      //print(googleKey?.idToken);

      // llamar servicio backend con el token
      // en local no funciona la llamada ya que la conexion debe hacerse a google mediante https para la validacion
      //final siginWithGoogleEndpoint =
      //  Uri(scheme: 'https', host: '10.0.2.2:3000', path: '/google');
      final session = await http.post(
        Uri.parse('https://10.0.2.2:3000/google'),
        body: {
          'token': googleKey?.idToken,
        },
      );
      // verificar que el estado es correcto, que se valido bien en el backedn
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
