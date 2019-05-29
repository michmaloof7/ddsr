import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';

class ArchivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  new Text('Lista de Pedidos')),
      body: SafeArea(child: Text('Pedidos')),
      drawer: BaseDrawer(),
    );
  }
}