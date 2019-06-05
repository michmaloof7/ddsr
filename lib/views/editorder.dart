import 'package:ddsr/services/apiservice.dart';
import 'package:ddsr/services/models/order/order.dart';
import 'package:ddsr/services/models/food/food.dart';
import 'package:ddsr/services/models/client/client.dart';
import 'package:flutter/material.dart';
import 'package:ddsr/functs/drawer.dart';
import 'dart:math';

var r = new Random();

class EditOrder extends StatefulWidget {
  
  EditOrder({Key key, this.order, this.clientlist}) : super(key: key);
  final Order order;
  final List<Client> clientlist;

  @override
  _State createState() => new _State();
}

class _State extends State<EditOrder>{
  String date;
  String clientDropVal;
  int statusDropVal;
  List<Food> foods;

  @override
  void initState() {
    super.initState();
    clientDropVal = _idtoName(widget.order.client_id);
    statusDropVal = widget.order.status;
    date = widget.order.deadline;
    foods = widget.order.items;
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2025)
    );
    if(picked != null) setState(() => date = picked.year.toString()+"/"+(picked.month < 10 ? "0"+picked.month.toString():picked.month.toString())+"/"+(picked.day < 10 ? "0"+picked.day.toString():picked.day.toString()));
  }

  String _idtoName(String id){
    for(Client n in widget.clientlist){
      if(n.id == id){
        return n.name;
      }
    }
    return "error";
  }

   String _nametoId(String name){
    for(Client n in widget.clientlist){
      if(n.name == name){
        return n.id;
      }
    }
    return "error";
  }

  @override
  Widget build(BuildContext context){
    List<String> namelist = [];
    for(Client i in widget.clientlist){
      namelist.add(i.name);
    }
    return Scaffold(
      appBar: AppBar(title: new Text('Editar un Pedido')),
      drawer: BaseDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              //Spacer(flex: 1,),
              new Row(
                children: <Widget>[
                  Text("Fecha de Entrega: "),
                  RaisedButton(
                    child: Text(date),
                    onPressed: (){_selectDate();}
                  )
                ],
              ),
              //Spacer(flex: 2,),
              new Row(
                children: <Widget>[
                  Text("Cliente: "),
                  DropdownButton(
                    value: clientDropVal,
                    items: namelist.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        clientDropVal = newValue;
                      });
                    },
                  ),
                ]
              ),
              //Spacer(flex: 2,),
              new Row(
                children: <Widget>[
                  Text("Estado: "),
                  DropdownButton(
                    value: statusDropVal == 0 ? "No Entregado":"Entregado",
                    items: [
                      DropdownMenuItem(
                        value: "No Entregado",
                        child: Text("No Entregado"),
                      ),
                      DropdownMenuItem(
                        value: "Entregado",
                        child: Text("Entregado"),
                      ),
                    ],
                    onChanged: (String newValue) {
                      setState(() {
                        newValue == "Entregado" ? statusDropVal = 1 : statusDropVal = 0;
                      });
                    },
                  ),
                ]
              ),
              new ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: foods.length+1,
                itemBuilder: (BuildContext context, int ind){
                  if(ind == foods.length){
                    return ListTile(
                      title: new Icon(Icons.add, color: Colors.grey[500],),
                      onTap: (){
                        setState(() {
                          foods.add(new Food(cost: 0, id: "", ingredients: [], name: "qwer", type: 0));
                        });
                      },
                    );
                  }
                  return Dismissible(
                    key: (foods[ind].id == "" ? Key(r.nextInt(999999999).toString()):Key(foods[ind].id)),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                          colors: [Colors.red, Colors.red[900]]
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.delete, color: Colors.white,)
                          )
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [Colors.red, Colors.red[900]]
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.delete, color: Colors.white,),
                          )
                        ],
                      ),
                    ),
                    child: ExpansionTile(
                      title: TextField(
                        controller: new TextEditingController.fromValue(new TextEditingValue(text: foods[ind].name)),
                        onSubmitted: (String text){
                          setState(() {
                           foods[ind].name = text; 
                          });
                        },
                      ),
                    ),
                    onDismissed: (direction){
                      setState(() {
                        foods.removeAt(ind);
                      });
                    }
                    );
                  },
                )
              ],
            )
          )
        )
      )
    );
  }
}