
import '../../core/models/words_model.dart';

interface class WordRepo {

  Future<WordsModel?> getWord(String word) async {
    throw UnimplementedError();
  }
}