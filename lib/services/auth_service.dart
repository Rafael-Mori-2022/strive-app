import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> init() async {
    print("AuthService pronto.");
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Login com Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("Login com Google cancelado pelo usuário.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, 
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      print("Usuário logado: ${userCredential.user?.displayName}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Erro no login com Google (Firebase): ${e.message}");
      return null;
    } catch (e) {
      print("Erro inesperado no login com Google: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      print("Usuário deslogado.");
    } catch (e) {
      print("Erro ao deslogar: $e");
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
