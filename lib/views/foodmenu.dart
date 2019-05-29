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
  int _activeMeterIndex;
  String msg;
  Future getfood;

  //only call the api once to get all the foods
  @override
  void initState() {
    super.initState();
    getfood = getAllFoods();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getfood,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //if we get data on the response then we will show it
        if (snapshot.hasData) {
          foodlist = snapshot.data;
          return Container(
            //create list with each food item
            child: new ListView.builder(
              //shrinkWrap: true,
              itemCount: foodlist.length,
              itemBuilder: (BuildContext context, int position) {
                final fooditem = foodlist[position];
                return Card(
                  //each food item can be expanded to see its details
                  child: new ExpansionPanelList(
                    expansionCallback: (int index, bool status) {
                      //know which fooditems are expanded or not
                      setState(() {
                        _activeMeterIndex = _activeMeterIndex == position ? null : position;
                      });
                    },
                    children: [
                      new ExpansionPanel(
                        //expansion cell header, where the main title shows, in this case
                        //the food name
                        isExpanded: _activeMeterIndex == position,
                        headerBuilder: (BuildContext context, bool isExpanded) =>
                        new Container(
                          padding: const EdgeInsets.only(left:15.0),
                          alignment: Alignment.centerLeft,
                          child: new Text(fooditem.name)
                        ),
                        //All the food details
                        body: new Container(
                          decoration: new BoxDecoration(boxShadow: [new BoxShadow(color: Colors.black,blurRadius: 85.0,),]),
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: new Card(
                            child:
                              new Column(
                              children: <Widget>[
                                //the row for the food price
                                new Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Precio: ')
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(fooditem.cost.toString())
                                    ),
                                  ]
                                ),
                                //the row for the food type
                                new Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Tipo de comida: ')
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(msg = fooditem.cost == 1 ? "Salado" : "Postre")
                                    ),
                                  ]
                                ),
                                new Container(
                                  child: new Card(
                                    child: 
                                    //we need to iterate over the ingredients
                                    new Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text("Ingredientes: "),
                                        new ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: fooditem.ingredients.length,
                                          itemBuilder: (BuildContext context, int i) {
                                            final ingredient = fooditem.ingredients[i];
                                            return new Column(
                                                children: <Widget>[
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
                                                      child: Text("Cantidad: ")
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text(ingredient.quantity.toString())
                                                    )
                                                  ]
                                                ),
                                                new Row(
                                                children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text("Tipo de unidad: ")
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text(ingredient.unit)
                                                    )
                                                  ]
                                                ),
                                                new Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text("- -")
                                                    )
                                                  ]
                                                ) 
                                              ]
                                            );
                                          }
                                        )
                                      ]
                                    )
                                  ) 
                                )
                              ]
                            )
                          )
                        )
                      )
                    ]
                  )
                );
              }
            )
          );
        } else {
          //show a circle progress indicator if no data
          return new CircularProgressIndicator();
        }
      }
    );
  }
}