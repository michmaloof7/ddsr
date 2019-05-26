import 'package:json_annotation/json_annotation.dart';
import 'dart:core';

part 'food.g.dart';

@JsonSerializable()
class Food {

  String id;
  String name;
  double cost;
  int type;
  List<Ingredients> ingredients;

  Food({
    this.id,
    this.name,
    this.cost,
    this.type,
    this.ingredients
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

@JsonSerializable()
class Ingredients {

  String name;
  String unit;
  int quantity;

  Ingredients({
    this.name,
    this.unit,
    this.quantity
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) => _$IngredientsFromJson(json);
}

