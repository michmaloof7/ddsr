import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';
import 'package:ddsr/services/models/client/client.dart';
import 'package:ddsr/services/models/food/food.dart';
import 'package:ddsr/services/models/order/order.dart';
import 'package:ddsr/services/apiservice.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Lista de comidas'),
      ),
      body: Center(
        child: FoodList(),
      )
    );
  }
}

class FoodList extends StatefulWidget {
  FoodList({Key key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Food> foodlist;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getAllFoods(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          foodlist = snapshot.data;
          return Container(
            child: new ListView.builder(
              itemCount: foodlist.length,
              itemBuilder: (BuildContext context, int position) {
                final fooditem = foodlist[position];
                return Card(
                  child: new InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(7.0),
                        child: new Row(
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.all(7.0),
                               child: new Text(fooditem.name),
                            )
                          ]
                        )
                      )
                    ],
                  ),
                  )
                );
              }
            )
          );
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }
}