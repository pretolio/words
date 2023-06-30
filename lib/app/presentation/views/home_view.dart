
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words/app/presentation/controllers/home_controller.dart';

import '../controllers/favorites_controller.dart';
import '../controllers/user_controller.dart';
import 'favorites_view.dart';
import 'history_view.dart';
import 'login_view.dart';
import 'word_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    HomeController.tabController = TabController(length: 3, vsync: this);
    context.read<FavoritesController>().getFavorite();
  }

  @override
  void dispose() {
    HomeController.tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Words'),
        actions: [
          if(context.watch<UserController>().user != null)
            IconButton(onPressed: (){
              context.read<UserController>().signOut(context);
            }, icon: Icon(Icons.logout_rounded, color: Colors.indigo,))
        ],
        bottom: TabBar(
          controller: HomeController.tabController,
          tabs: const [
            Tab(text: 'Word List'),
            Tab(text: 'History'),
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          controller: HomeController.tabController,
          children: [
            const WordListView(),
            const HistoryView(),
            context.watch<UserController>().user == null
                ? const LoginView() : const FavoritesView(),
          ],
        ),
      ),
    );
  }
}
