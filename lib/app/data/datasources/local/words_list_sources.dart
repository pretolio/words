import 'dart:convert';

import 'package:flutter/services.dart';

import '../../repositories/words_list_repo.dart';


class WordsListSources implements WordsListRepo {

  @override
  Future<List<String>> loadWordsList() async {
    final jsonString = await rootBundle.loadString('assets/json/words_dictionary.json');
    final jsonMap = jsonDecode(jsonString);

    final List<String> words = jsonMap.keys.cast<String>().toList();

    return words;
  }
}