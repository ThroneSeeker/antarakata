import 'package:antarakata/page/detail_page.dart';
import 'package:antarakata/page/home_page.dart';
import 'package:antarakata/page/result_kategori.dart';
import 'package:antarakata/page/result_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/detail' : (BuildContext context) => new DetailPage(),
        '/result-kategori' : (BuildContext context) => new ResultKategoriPage(),
        '/result-search' : (context) => new ResultSearchPage()
      },
      home: HomePage(),
    );
  }
}