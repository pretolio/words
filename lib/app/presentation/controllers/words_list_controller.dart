
import '../../data/datasources/local/words_list_sources.dart';
import 'providers.dart';

class WordsListController extends DisposableProvider {
  final WordsListSources _sourcesList = WordsListSources();

  List<String> wordsList = [];
  List<String> wordsFiltered = [];
  List<String> wordsHistory = [];
  List<String> wordsHistoryFiltered = [];

  String? search;

  WordsListController(){
    loadWords();
  }

  void updateHistoryList(){
    wordsHistoryFiltered = search == null || search!.isEmpty ? wordsHistory :
    wordsHistory.where((e) => e.toLowerCase().contains(search!.toLowerCase())).toList();
    notifyListeners();
  }

  void updateList(){
    wordsFiltered = search == null || search!.isEmpty ? wordsList :
      wordsList.where((e) => e.toLowerCase().contains(search!.toLowerCase())).toList();
    notifyListeners();
  }

  void addHistory(String value){
    if(!wordsHistory.any((e) => e == value)){
      wordsHistory.add(value);
      wordsHistoryFiltered = wordsHistory.reversed.toList();
    }else{
      wordsHistory.remove(value);
      wordsHistory.add(value);
      wordsHistoryFiltered = wordsHistory.reversed.toList();
    }
  }

  Future<void> loadWords() async {
    wordsList = await _sourcesList.loadWordsList();
    wordsFiltered = wordsList;
    notifyListeners();
  }

  @override
  void disposeValues() {
    search = null;
    wordsHistory = [];
  }
}