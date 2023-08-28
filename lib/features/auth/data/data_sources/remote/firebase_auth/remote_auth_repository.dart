import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteAuthRepository {
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}
