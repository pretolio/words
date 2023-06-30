

import 'package:firebase_auth/firebase_auth.dart';

interface class FireAuthRepo {

  Future<UserCredential> signIn(String email, String password,) async {
    throw UnimplementedError();
  }

  Future<UserCredential> createUser(String email, String password,) async {
    throw UnimplementedError();
  }

  Future<void> sendPassword(String email) async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    throw UnimplementedError();
  }

}