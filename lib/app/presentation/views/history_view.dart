

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../routes.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/words_list_controller.dart';
import '../widgets/custom_snackbar.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
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
                    const Text('History', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    TextField(
                      onChanged: ( value) {
                        word.search = value;
                        word.updateHistoryList();
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
                child: GridView.builder(
                  itemCount: word.wordsHistoryFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = word.wordsHistoryFiltered[index];
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
