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
            title: Text('First Page'),
            onTap: (){
              if(currentRoute == '/') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/');
            }
          ),
          ListTile(
            title: Text('Second Page'),
            onTap: (){
              if(currentRoute == '/second') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/archive');
            }
          ),
          ListTile(
            title: Text('Third Page'),
            onTap: (){
              if(currentRoute == '/third') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/foods');
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
