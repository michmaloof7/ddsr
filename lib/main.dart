import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appTitle',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHome(),
        '/second': (context) => SecondPage()
      },
    );
  }
}

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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('Item 1'),
            onTap: (){
              if(currentRoute == '/') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/');
            }
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: (){
              if(currentRoute == '/second') return;
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/second');
            }
          ),
        ],
      ),
    );
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

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text('asdf')),
      body: Text('first page'),
      drawer: BaseDrawer(),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  new Text('asdf')),
      body: Text('second page'),
      drawer: BaseDrawer(),
    );
  }
}