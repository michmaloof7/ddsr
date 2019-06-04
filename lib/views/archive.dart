import 'package:ddsr/services/apiservice.dart';
import 'package:ddsr/services/models/order/order.dart';
import 'package:ddsr/services/models/food/food.dart';
import 'package:ddsr/services/models/client/client.dart';
import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';

class ArchivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  new Text('Lista de Pedidos')),
      drawer: BaseDrawer(),
      body: SafeArea(child: Center(child: OrderList()))
    );
  }
}

class OrderList extends StatefulWidget {
  OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  
  Future setall;
  Future setclient;
  List<Client> clients;
  List<Order> orderlist;
  List<String> clientsnames = [];
  int _activeMeterIndex;

  @override
  void initState() {
    super.initState();
    setall = getAllOrders();
    setclient = getAllClients(); 
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: setall,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          orderlist = snapshot.data;
          return new FutureBuilder(
            future: setclient,
            builder: (BuildContext innercontext, AsyncSnapshot innersnapshot) {
              if(innersnapshot.hasData) {
                clients = innersnapshot.data;
                setnames();
                return new ListView.builder(
                  itemCount: orderlist.length,
                  itemBuilder: (BuildContext context, int position) {
                    final orderitem = orderlist[position];
                    orderitem.items.sort((a, b) {return a.name.toLowerCase().compareTo(b.name.toLowerCase());});
                    return new Card(
                      child: new ExpansionPanelList(
                        expansionCallback: (int index, bool status) {
                          //know which fooditems are expanded or not
                          setState(() {
                            _activeMeterIndex = _activeMeterIndex == position ? null : position;
                          });
                        },
                        children: [
                          new ExpansionPanel(
                            isExpanded: _activeMeterIndex == position,
                            headerBuilder: (BuildContext context, bool isExpanded) =>
                            new Container(
                              padding: const EdgeInsets.only(left:15.0),
                              alignment: Alignment.centerLeft,
                              child: new Text("Orden "+orderitem.deadline)
                            ),
                            body: new Container(
                              decoration: new BoxDecoration(boxShadow: [new BoxShadow(color: Colors.green[300],blurRadius: 85.0,),]),
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: new Card(
                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Fecha de Entrega: ' + orderitem.deadline),
                                        )
                                      ],
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Costo total: ' + totalcost(orderitem.items).toString())
                                        ),
                                      ]
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Nombre cliente: ' + clientsnames[position])
                                        ),
                                      ]
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Estado: ' + (orderitem.status == 0 ? "No entregado" : "Entregado"))
                                        ),
                                      ]
                                    ),
                                    new Container(
                                      child: new Card(
                                        color: Colors.grey[100],
                                        child: new Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: 20, bottom: 10),
                                              child: new Text("Items: "),
                                            ),
                                            new ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: orderitem.items.length,
                                              itemBuilder: (BuildContext context, int i) {
                                                final item = orderitem.items[i];
                                                int inglistlength;
                                                if(item.ingredients == null){
                                                  inglistlength = 1;
                                                } else {
                                                  inglistlength = item.ingredients.length;
                                                }
                                                return new Column(
                                                  children: <Widget>[
                                                    new ExpansionTile(
                                                      title: Text("• " + item.name),
                                                      children: <Widget>[
                                                        new ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: inglistlength,
                                                          itemBuilder: (BuildContext context, int i) {
                                                            if(inglistlength==1){
                                                              return Center(
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(20),
                                                                  child: Text("Sin ingredientes")
                                                                )
                                                              );
                                                            }
                                                            final ingredient = item.ingredients[i];
                                                            return new Column(
                                                              children: <Widget>[
                                                                new Divider(),
                                                                new Row(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets.all(8),
                                                                      child: Text("Ingrediente: ")
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.all(8),
                                                                      child: Text(ingredient.name)
                                                                    )
                                                                  ]
                                                                ),
                                                                new Row(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets.all(8),
                                                                      child: Text("Cantidad: "+ingredient.quantity.toString()+" "+ingredient.unit)
                                                                    ),
                                                                  ]
                                                                ),
                                                              ]
                                                            );
                                                          }
                                                        )
                                                      ],
                                                    )
                                                  ]
                                                );
                                              }
                                            )
                                          ]
                                        )
                                      )
                                    )
                                  ],
                                )
                              ),
                            )
                          )
                        ],
                      ),
                    );
                  }
                );
              }else if (snapshot.hasError) {
                return new Text('Error fetching clients');
              } else {
                return new CircularProgressIndicator();
              }
            }
          );
        } else if (snapshot.hasError) {
          return new Text('Error fetching orders');
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }

  //Function to get the total cost of the orders
  double totalcost(items) {
    double sum = 0.0;
    for(Food item in items){
      sum += item.cost;
    }
    return sum;
  }

  void setnames() {
    for(Order order in orderlist) {
      for(Client client in clients) {
        if(client.id == order.client_id) {
          clientsnames.add(client.name);
        }
      }
    }
  }
}