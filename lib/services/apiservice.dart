import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'models/client/client.dart';
import 'models/food/food.dart';
import 'models/order/order.dart';

//Introduce your machine local IP
String url = 'https://<yourlocalmachineip>/mongo';

//request headers
var headers = {'Content-type':'application/json',
               'accept': 'application/json'};

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

//-------- FOOD OPERATIONS -----------------

//get all foods
Future<List<Food>> getAllFoods() async {
  final response = await http.get(url+collections['foods']+methods['get'], 
                                  headers: headers);
  //if we get a positive response parse the data
  if (response.statusCode == 200) {
    final jsonresponse = (json.decode(response.body) as List)
                        .map((data) => new Food.fromJson(data)).toList();
    return jsonresponse;
  }
  else {
    throw Exception('Failed to fetch all foods');
  }
}

//get food by id
Future<Food> getFoodById(String id) async {
  final response = await http.get(url+collections['foods']+methods['get']+id, 
                                  headers: headers);

  if (response.statusCode == 200) {
    return Food.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Food not found');
  }
}

//add new food
Future<http.Response> addFood(Map data) async {
  var newfood = new Food.fromJson(data);
  newfood.toJson();
  final request = await http.post(url+collections['foods']+methods['post'],
                                  headers: headers, 
                                  body: newfood);

  if (request.statusCode == 200) {
    return request;
  } 
  else {
    throw Exception('Food not added');
  }
}

//update food
Future<http.Response> updateFood(Map data) async {
  var updatedfood = new Food.fromJson(data);
  updatedfood.toJson();
  final request = await http.post(url+collections['foods']+methods['update']+data['id'], 
                                  headers: headers, 
                                  body: updatedfood);

  if (request.statusCode == 200) {
    return request;
  }
  else {
    throw Exception('Food Updated');
  }
}

//delete food
Future<http.Response> deleteFood(String id) async {
  final request = await http.post(url+collections['foods']+methods['delete']+id,
                                  headers: headers);
  if (request.statusCode == 200) {
    return request;
  }
  else {
    throw Exception('Food Deleted');
  }
}

//--------- CLIENT OPERATIONS -----------

//get all clients
Future<List<Client>> getAllClients() async {
  final response = await http.get(url+collections['clients']+methods['get'],
                                  headers: headers);
  //if we get a positive response parse the data
  if (response.statusCode == 200) {
    final jsonresponse = (json.decode(response.body) as List)
                        .map((data) => new Client.fromJson(data)).toList();
    return jsonresponse;
  }
  else {
    throw Exception('Failed to fetch all foods');
  }
}

//get client by id
Future<Client> getClientById(String id) async {
 final response = await http.get(url+collections['clients']+methods['get']+id, 
                                  headers: headers);

  if (response.statusCode == 200) {
    return Client.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Client not found');
  }

}

//add new client
Future<http.Response> addClient(Map data) async {
  var newclient = new Client.fromJson(data);
  newclient.toJson();
  final request = await http.post(url+collections['clients']+methods['post'],
                                  headers: headers, 
                                  body: newclient);

  if (request.statusCode == 200) {
    return request;
  } 
  else {
    throw Exception('Clint not added');
  }
}

//update client
Future<http.Response> updateClient(Map data) async {
  var updatedclient = new Food.fromJson(data);
  updatedclient.toJson();
  final request = await http.post(url+collections['clients']+methods['update']+data['id'], 
                                  headers: headers, 
                                  body: updatedclient);

  if (request.statusCode == 200) {
    return request;
  }
  else {
    throw Exception('Client not Updated');
  }
}


//-------------- ORDER OPERATIONS ------------------

//get all orders
Future<List<Order>> getAllOrders() async {
  final response = await http.get(url+collections['orders']+methods['get'], 
                                  headers: headers);

  //if we get a positive response parse the data
  if (response.statusCode == 200) {
    final jsonresponse = (json.decode(response.body) as List)
                        .map((data) => new Order.fromJson(data)).toList();
    return jsonresponse;
  }
  else {
    throw Exception('Failed to fetch all orders');
  }
}

//get order by id
Future<Order> getOrderById(String id) async {
  final response = await http.get(url+collections['orders']+methods['get']+id, 
                                  headers: headers);

  if (response.statusCode == 200) {
    return Order.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Order not found');
  }
}

//add new order
Future<http.Response> addOrder(Map data) async {
  var neworder = new Order.fromJson(data);
  neworder.toJson();
  final request = await http.post(url+collections['orders']+methods['post'],
                                  headers: headers, 
                                  body: neworder);

  if (request.statusCode == 200) {
    return request;
  } 
  else {
    throw Exception('Order not added');
  }
}

//update order
Future<http.Response> updateOrder(Map data) async {
  var updatedorder = new Order.fromJson(data);
  updatedorder.toJson();
  final request = await http.post(url+collections['orders']+methods['update']+data['id'], 
                                  headers: headers, 
                                  body: updatedorder);

  if (request.statusCode == 200) {
    return request;
  }
  else {
    throw Exception('Order not Updated');
  }
}

//delete order
Future<http.Response> deleteOrder(String id) async {
  final request = await http.post(url+collections['orders']+methods['delete']+id,
                                  headers: headers);
  if (request.statusCode == 200) {
    return request;
  }
  else {
    throw Exception('Order Deleted');
  }
}