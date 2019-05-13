import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  new Text('asdf')),
      body: SafeArea(child: Text('second page')),
      drawer: BaseDrawer(),
    );
  }
}