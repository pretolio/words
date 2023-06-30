

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasources/remote/firestore_sources.dart';
import '../../data/repositories/firestore_repo.dart';
import 'providers.dart';

class FavoritesController extends DisposableProvider {
  final FirestoreRepo _sources = FirestoreSources();
  List<String> listFavorites = [];

  String? _search;
  String? get search => _search;
  set search(String? v){
    _search = v;
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteStream() {
    final stream = _sources.getFavoriteStream();

    return stream;
  }

  Future<void> getFavorite()  async {
    final list = await _sources.getFavorite();
    listFavorites = list;
    notifyListeners();
  }

  Future<void> addFavorite(String word) async {
    await _sources.addFavorite(word);
    listFavorites.add(word);
    notifyListeners();
  }


  Future<void> deleteFavorite(String docID) async {
    await _sources.deleteFavorite(docID);
    listFavorites.remove(docID);
    notifyListeners();
  }

  @override
  void disposeValues() {
    listFavorites = [];
    _search = null;
  }

}