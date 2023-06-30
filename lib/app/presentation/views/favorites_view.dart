

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../routes.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/words_list_controller.dart';
import '../widgets/custom_snackbar.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {

  @override
  void initState() {
    context.read<FavoritesController>().getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<FavoritesController>(
        builder: (context, favorite, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Favorites', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    TextField(
                      onChanged: ( value) {
                        favorite.search = value;
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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: favorite.getFavoriteStream(),
                  builder: (BuildContext context, snapshot) {

                    Widget resultado = Container();

                    switch( snapshot.connectionState ){
                      case ConnectionState.none :
                      case ConnectionState.waiting :
                        resultado = const Center(child: CircularProgressIndicator());
                        break;
                      case ConnectionState.active :
                      case ConnectionState.done :
                        if( snapshot.hasError ){
                          resultado = GestureDetector(
                              child: const Icon(Icons.autorenew_outlined, size: 70,),
                              onTap: (){
                                setState(() {});
                              }
                          );
                        }else if(snapshot.data != null) {
                          final data = snapshot.data!;

                          resultado = GridView.builder(
                            itemCount: data.docChanges.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = data.docChanges[index];
                              final Map<String, dynamic>? mapItem = item.doc.data();

                              return InkWell(
                                key: Key('${item.doc.id}'),
                                onTap: (){
                                  context.read<WordsListController>().addHistory( mapItem?['word']);
                                  Navigator.pushNamed(context, RouteName.word.value, arguments: mapItem?['word']);
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Card(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(mapItem?['word'] ,
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
                                            context.read<FavoritesController>().deleteFavorite(mapItem?['word']).catchError((erro){
                                              debugPrint(erro.toString());
                                              CustomSnackbar.error(
                                                  text: 'Não foi possivel remover do favoritos, verifique sua internet e tente novamente!',
                                                  context: context);
                                            });

                                        },
                                        icon: Icon(CupertinoIcons.trash, color: Colors.red, size: 18,)
                                    )
                                  ],
                                ),
                              );
                            },
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                          );
                        }else{
                          resultado = Center(
                            child: Text('No words added to favorites'),
                          );
                        }
                        break;
                    }
                    return resultado;
                  },

                )
              )
            ],
          );
        }
    );
  }
}
