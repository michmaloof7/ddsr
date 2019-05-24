import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

//Introduce your machine local IP
String url = 'https://<yourlocalmachineip>/mongo';

//the name of the collections we have in the database
var collections = {
    'foods': '/foods',
    'orders': '/orders',
    'clients': '/clients',
};

//the HTTP methods, they are simplified
var methods = {
    'get': '/',
    'post': '/add',
    'delete': '/delete/',
    'getByType': '/type/',
    'update': '/update/'
};
