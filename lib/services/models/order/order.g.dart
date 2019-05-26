// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
      id: json['id'] as String,
      client_id: json['client_id'] as String,
      deadline: json['deadline'] as String,
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : Food.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      status: json['status'] as int);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'client_id': instance.client_id,
      'deadline': instance.deadline,
      'items': instance.items,
      'status': instance.status
    };
