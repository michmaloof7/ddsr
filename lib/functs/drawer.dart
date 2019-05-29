import 'package:flutter/material.dart';

class BaseDrawer extends StatelessWidget{
  String getCurrentRouteName(context) {
    String currentRouteName;

    Navigator.popUntil(context, (route) {
      currentRouteName = route.settings.name;
      return true;
    });

    return currentRouteName;
  }
  @override
  Widget build(BuildContext context){
    String currentRoute = getCurrentRouteName(context);
    return SafeArea(child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('Home'),
            onTap: (){
              if(currentRoute == '/') return;
              Navigator.pop(context);
              Navigator.of(context).popUntil(ModalRoute.withName("/"));
            }
          ),
          ListTile(
            title: Text('Pedidos'),
            onTap: (){
              if(currentRoute == '/second') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/archive', ModalRoute.withName("/"));
            }
          ),
          ListTile(
            title: Text('Comidas'),
            onTap: (){
              if(currentRoute == '/third') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/foods', ModalRoute.withName("/"));
            }
          )
        ],
      ),
    ));
  }
}

String getCurrentRouteName(context) {
  String currentRouteName;

  Navigator.popUntil(context, (route) {
    currentRouteName = route.settings.name;
    return true;
  });
  return currentRouteName;
}
