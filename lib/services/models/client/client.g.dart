// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as int,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      city: json['city'] as String,
      street_address: json['street_address'] as String);
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'street_address': instance.street_address
    };
