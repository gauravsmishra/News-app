import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/news_search_screen.dart';

import 'ui/screens/news_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NewsHomeScreen());
  }
}
