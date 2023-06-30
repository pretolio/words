

import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/repositories/fireauth_service.dart';
import '../../repositories/fireauth_repo.dart';


class FireAuthSources extends FireAuthServiceRepo implements FireAuthRepo {

  @override
  Future<UserCredential> createUser(String email, String password) async {
    return await fireAuth.createUser(email, password);
  }

  @override
  Future<void> sendPassword(String email) async {
    await fireAuth.sendPassword(email);
  }

  @override
  Future<UserCredential> signIn(String email, String password) async {
    return await fireAuth.signIn(email, password);
  }

  @override
  Future<void> signOut() async {
    return await fireAuth.signOut();
  }

}