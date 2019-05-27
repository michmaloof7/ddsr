// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) {
  return Food(
      id: json['id'] as String,
      name: json['name'] as String,
      cost: (json['cost'] as num)?.toDouble(),
      type: json['type'] as int,
      ingredients: (json['ingredients'] as List)
          ?.map((e) => e == null
              ? null
              : Ingredients.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': instance.cost,
      'type': instance.type,
      'ingredients': instance.ingredients
    };

Ingredients _$IngredientsFromJson(Map<String, dynamic> json) {
  return Ingredients(
      name: json['name'] as String,
      unit: json['unit'] as String,
      quantity: json['quantity'] as int);
}

Map<String, dynamic> _$IngredientsToJson(Ingredients instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unit': instance.unit,
      'quantity': instance.quantity
    };
