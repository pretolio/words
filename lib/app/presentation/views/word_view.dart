

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/words_model.dart';
import '../controllers/word_controller.dart';
import '../widgets/custom_text_to_speech.dart';

class WordView extends StatefulWidget {
  const WordView( this.word, {super.key});
  final String word;
  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.word),),
      body: FutureBuilder<WordsModel?>(
        future: context.read<WordController>().getWord(widget.word),
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

                resultado = Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo.shade100),
                          color: Colors.indigo.shade50
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(data.word ?? '', style: const TextStyle(fontSize: 18),),
                            Text(data.pronunciation?.all ?? '', style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10,),
                      const Text('Meanings', style: TextStyle(fontSize: 28),),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data.results?.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(e.definition != null)
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text('Definition: ${e.definition}'),
                                    ),
                                  ),
                                  SizedBox(height: 30,width: 30,
                                      child: CustomTextToSpeech(e.definition ?? '')),
                                ],
                              ),
                              if(e.derivation != null && e.derivation!.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  const Text('Derivation:'),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: e.derivation?.map((el) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(el)),
                                          SizedBox(height: 30,width: 30,
                                              child: CustomTextToSpeech(e.definition ?? '')),
                                        ],
                                      ),
                                    )).toList() ?? [],
                                  ),
                                ],
                              ),
                              if(e.examples != null && e.examples!.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  const Text('Examples:'),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: e.examples?.map((el) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text(el)),
                                          SizedBox(height:30,width: 30,
                                              child: CustomTextToSpeech(e.definition ?? '')),
                                        ],
                                      ),
                                    )).toList() ?? [],
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ],
                          );
                        }).toList() ?? [],
                      )
                    ],
                  ),
                );
              }else{
                resultado = Center(
                  child: Text('Unable to query word: ${widget.word}'),
                );
              }
              break;
          }
          return resultado;
        },
      )
    );
  }
}
