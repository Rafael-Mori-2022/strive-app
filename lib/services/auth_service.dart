import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  
  Future<void> init() async {
    try {
      await _googleSignIn.initialize();
      print("GoogleSignIn inicializado com sucesso.");
    } catch (e) {
      print("Erro ao inicializar GoogleSignIn: $e");
    }
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Login com Google
  Future<User?> signInWithGoogle() async {
    try {
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        print("Login com Google cancelado pelo usuário.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null) {
        print("Erro: Google idToken está nulo.");
        return null;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
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

  // Método de Logout
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