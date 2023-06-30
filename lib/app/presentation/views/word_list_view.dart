

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:words/app/presentation/controllers/favorites_controller.dart';

import '../../routes.dart';
import '../controllers/home_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/words_list_controller.dart';
import '../widgets/custom_snackbar.dart';

class WordListView extends StatefulWidget {
  const WordListView({super.key});

  @override
  State<WordListView> createState() => _WordListViewState();
}

class _WordListViewState extends State<WordListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordsListController>(
      builder: (context, word, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Word List', style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  TextField(
                    onChanged: ( value) {
                      word.search = value;
                      word.updateList();
                    },
                    scrollPadding: EdgeInsets.zero,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReorderableGridView.builder(
                itemCount: word.wordsFiltered.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = word.wordsFiltered[index];
                  bool isFavorite = context.watch<FavoritesController>().listFavorites.any((e) => e==item);
                  return InkWell(
                    key: Key('${item.trim()}'),
                    onTap: (){
                      word.addHistory(item);
                      Navigator.pushNamed(context, RouteName.word.value, arguments: item);
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(item,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: (){
                              if(context.read<UserController>().user == null){
                                HomeController.setPage(2);
                              }
                              else if(isFavorite) {
                                context.read<FavoritesController>().deleteFavorite(item).catchError((erro){
                                  debugPrint(erro.toString());
                                  CustomSnackbar.error(
                                      text: 'Não foi possivel remover do favoritos, verifique sua internet e tente novamente!',
                                      context: context);
                                });
                              } else {
                                context.read<FavoritesController>().addFavorite(item).catchError((erro){
                                  debugPrint(erro.toString());
                                  CustomSnackbar.error(
                                      text: 'Não foi possivel salvar no favoritos, verifique sua internet e tente novamente!',
                                      context: context);
                                });
                              }
                            },
                            icon: Icon(isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                              color: isFavorite ? Colors.red : Colors.blue,)
                        )
                      ],
                    ),
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    final item = word.wordsFiltered.removeAt(oldIndex);
                    word.wordsFiltered.insert(newIndex, item);
                  });
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
