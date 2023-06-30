

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'favorites_controller.dart';
import 'user_controller.dart';
import 'word_controller.dart';
import 'words_list_controller.dart';

export 'package:flutter/material.dart';

class Providers {

  static List<SingleChildWidget> listProviders() {
    return [
      ChangeNotifierProvider(
        create: (_)=>  WordsListController(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_)=>  WordController(),
      ),
      ChangeNotifierProvider(
        create: (_)=>  FavoritesController(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_)=>  UserController(),
        lazy: false,
      ),
    ];
  }

  static List<DisposableProvider> _getDisposableProviders(BuildContext context) {
    return [
      Provider.of<WordsListController>(context, listen: false),
      Provider.of<UserController>(context, listen: false),
      Provider.of<FavoritesController>(context, listen: false),
      //...other disposable providers
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    _getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }

}

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}