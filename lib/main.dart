import 'package:flutter/material.dart';
import 'package:ddsr/views/home.dart';
import 'package:ddsr/views/archive.dart';
import 'package:ddsr/views/foodmenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'appTitle',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHome(),
        '/archive': (context) => ArchivePage(),
        '/foods': (context) => FoodPage()
      },
    );
  }
}


