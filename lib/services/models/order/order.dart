import 'package:json_annotation/json_annotation.dart';
import '../food/food.dart';
import 'dart:core';

part 'order.g.dart';

@JsonSerializable()
class Order {
  String id;
  String client_id;
  String deadline;
  List<Food> items;
  int status;

  Order({
    this.id,
    this.client_id,
    this.deadline,
    this.items,
    this.status
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}