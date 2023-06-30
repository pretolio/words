

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/repositories/firestore_service.dart';
import '../../repositories/firestore_repo.dart';

class FirestoreSources extends FirestoreServiceRepo implements FirestoreRepo {

  @override
  Future<void> addFavorite(String word) async {
    await fireStore.uploadingData('Favorites', word);
  }

  @override
  Future<void> deleteFavorite(String docID) async {
    await fireStore.deleteData('Favorites', docID);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteStream() {
    return fireStore.getDataStream('Favorites');
  }

  @override
  Future<List<String>> getFavorite() async {
    final querySnapshot = await fireStore.getData('Favorites');
    List<String> list = querySnapshot.docChanges.map((e) {
      String txt = e.doc.data()!['word'];
      return txt;
    }).toList();
    return list;
  }

}