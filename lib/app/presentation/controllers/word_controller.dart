


import '../../core/models/words_model.dart';
import '../../data/datasources/remote/word_sources.dart';
import 'providers.dart';

class WordController extends ChangeNotifier {
  final WordSources _sources = WordSources();
  List<WordsModel> cacheList = [];

  Future<WordsModel?> getWord(String word) async {
    if(cacheList.isNotEmpty && cacheList.any((e) => e.word == word)){
      return cacheList.firstWhere((e) => e.word == word);
    }
    final result = await _sources.getWord(word);
    if(result != null){
      cacheList.add(result);
      return result;
    }
  }

}