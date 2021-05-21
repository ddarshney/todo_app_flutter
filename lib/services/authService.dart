import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth;

  AuthService() {
    _auth = FirebaseAuth.instance;
  }

  Stream<User> get authStateChanges => _auth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user.uid;
    } on FirebaseAuthException catch (e) {
      print('Error! $e');
      return null;
    }
  }

  Future<void> register({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Error! $e");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
