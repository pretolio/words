

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  final CollectionReference<Map<String, dynamic>> _firestore = FirebaseFirestore.instance.collection('Words');

  Future<void> uploadingData(String collection, String word) async {
    await _firestore.doc(FirebaseAuth.instance.currentUser?.uid).collection(collection).doc(word).set({'word': word});
  }

  Future<void> deleteData(String collection, String docId) async {
    await _firestore.doc(FirebaseAuth.instance.currentUser?.uid).collection(collection).doc(docId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataStream(String collection) {
    return _firestore.doc(FirebaseAuth.instance.currentUser?.uid).collection(collection).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData(String collection) async {
    return await _firestore.doc(FirebaseAuth.instance.currentUser?.uid).collection(collection).get();
  }
}