import 'package:flutter/material.dart';
import 'package:ddsr/views/home.dart';
import 'package:ddsr/views/second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appTitle',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHome(),
        '/second': (context) => SecondPage()
      },
    );
  }
}


