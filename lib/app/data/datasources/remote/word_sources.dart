

import '../../../core/models/words_model.dart';
import '../../../core/repositories/api_service.dart';
import '../../repositories/word_repo.dart';

class WordSources extends ApiServiceRepo implements WordRepo {
  final String _url = 'https://wordsapiv1.p.rapidapi.com/words/';

  @override
  Future<WordsModel?> getWord(String word) async {
    final result = await httpCli.get(url: '$_url$word',
      headers:  {
        'X-RapidAPI-Key': '80fa04e900msha2380afc4dc8d93p14f101jsn1094b29cbc0c',
        'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
        'X-Mashape-Key': '80fa04e900msha2380afc4dc8d93p14f101jsn1094b29cbc0c'
      }
    );
    if(result.isSucess){
      Map<String, dynamic> map = result.data;
      WordsModel model = WordsModel.fromMap(map);
      return model;
    }
    return null;
  }
}