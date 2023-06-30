

import 'package:cloud_firestore/cloud_firestore.dart';

interface class FirestoreRepo {

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteStream() {
    throw UnimplementedError();
  }
  Future<List<String>> getFavorite() async {
    throw UnimplementedError();
  }
  Future<void> addFavorite(String word) async {
    throw UnimplementedError();
  }

  Future<void> deleteFavorite(String docID) async {
    throw UnimplementedError();
  }
}