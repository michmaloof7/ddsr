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
  List<Order> orderlist;
  Future getorders;
  int _activeMeterIndex;

  @override
  void initState() {
    super.initState();
    getorders = getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getorders,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          orderlist = snapshot.data;
          return new ListView.builder(
            itemCount: orderlist.length,
            itemBuilder: (BuildContext context, int position) {
              final orderitem = orderlist[position];
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
                                    child: Text('Precio: ')
                                  ),
                                ]
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
        } else{
          return new CircularProgressIndicator();
        }
      }
    );
  }
}