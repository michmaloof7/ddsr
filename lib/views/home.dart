import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text('asdf')),
      body: SafeArea(child: Text('first page')),
      drawer: BaseDrawer(),
    );
  }
}