

import 'package:flutter/material.dart';

import 'presentation/views/home_view.dart';
import 'presentation/views/word_view.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (RouteName.stringToRoute(settings.name)) {
      case RouteName.home:
        return MaterialPageRoute(
            builder: (_) => const HomeView()
        );
      case RouteName.word:
        return MaterialPageRoute(
            builder: (_) => WordView(settings.arguments as String)
        );
      case RouteName.login:
        return MaterialPageRoute(
            builder: (_) => const HomeView()
        );
      default:
        return _erroRota();
    }
  }


  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title:const Text("Tela não encontrada!"),),
            body: const Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );
  }
}

enum RouteName {
  home('/'),
  word('/word'),
  login('/login');

  static RouteName stringToRoute(String? v){
    RouteName rote = RouteName.values.firstWhere((e) => e.value == v);
    return rote;
  }

  final String value;
  const RouteName(this.value);
}