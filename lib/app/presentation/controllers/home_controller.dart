

import 'package:flutter/material.dart';

class HomeController {
  static late TabController tabController;

  static void setPage(int page){
    tabController.animateTo(page);
  }
}