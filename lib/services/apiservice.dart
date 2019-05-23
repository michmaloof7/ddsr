import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_json/model/post_model.dart';
import 'dart:io';

String url = 'https://<yourlocalmachineip>/mongo'

#the name of the collections we have in the database
collections = {
    foods: '/foods',
    orders: '/orders',
    clients: '/clients',
};

#the HTTP methods, they are simplified
methods = {
    get: '/',
    post: '/add',
    delete: '/delete/',
    getByType: '/type/',
    update: '/update/'
};
