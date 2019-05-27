import 'package:ddsr/views/menu.dart';
import 'package:flutter/material.dart';
import 'package:ddsr/views/home.dart';
import 'package:ddsr/views/archive.dart';

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
        '/menu': (context) => MenuPage()
      },
    );
  }
}


