import 'package:json_annotation/json_annotation.dart';
import 'dart:core';

part 'client.g.dart';

@JsonSerializable()
class Client {
 
  String id;
  String name;
  int phone;
  Address address;

  Client({
    this.id,
    this.name,
    this.phone,
    this.address
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class Address {
  String city;
  String street_address;

  Address({
    this.city,
    this.street_address
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}