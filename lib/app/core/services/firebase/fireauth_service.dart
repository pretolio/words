

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FireAuthService(){
    _auth.setLanguageCode('pt-BR');
  }

  Future<UserCredential> signIn(String email, String password,) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUser(String email, String password,) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}