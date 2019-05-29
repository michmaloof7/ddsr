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
          child: Container(
              margin: EdgeInsets.all(10.0),
              child:
                Column(
                children: <Widget>[
                  Card(
                    color: Colors.grey[100],
                    child: new InkWell(
                      child: 
                      new Padding(
                        padding: const EdgeInsets.all(5),
                        child: RaisedButton.icon(
                              icon: Icon(Icons.receipt),
                              label: Text("Registro de Pedidos"),
                              onPressed: (){Navigator.of(context).pushNamed('/archive');},
                              color: Colors.grey[100],
                        )
                      ),
                    )
                  ),
                  Card(
                    color: Colors.grey[200],
                    child: new InkWell(
                      child: 
                      new Padding(
                        padding: const EdgeInsets.all(5),
                        child: RaisedButton.icon(
                              icon: Icon(Icons.account_box),
                              label: Text("Lista de Clientes"),
                              onPressed: (){},
                              color: Colors.grey[200],
                        )
                      ),
                    )
                  ),
                  Card(
                    color: Colors.grey[300],
                    child: new InkWell(
                      child: 
                        new Padding(
                          padding: const EdgeInsets.all(5),
                          child: 
                            RaisedButton.icon(
                              icon: Icon(Icons.fastfood),
                              label: Text("Nuevo Pedido"),
                              onPressed: (){},
                              color: Colors.grey[300],
                        )
                      ),
                    )
                  ),
                  
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch
              )
          )
        )
      ),
    );
  }
}