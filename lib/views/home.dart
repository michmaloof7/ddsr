import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text('Menu Principal')),
      drawer: BaseDrawer(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(Icons.receipt),
                label: Text("Registro de Pedidos"),
                onPressed: (){Navigator.of(context).pushNamed('/archive');},
                color: Colors.greenAccent,
              ),
              RaisedButton.icon(
                icon: Icon(Icons.account_box),
                label: Text("Lista de Clientes"),
                onPressed: (){},
                color: Colors.greenAccent,
              ),
              RaisedButton.icon(
                icon: Icon(Icons.fastfood),
                label: Text("Nuevo Pedido"),
                onPressed: (){},
                color: Colors.greenAccent,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        )
      ),
    );
  }
}