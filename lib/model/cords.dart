import 'dart:convert';

import 'package:weather_app/model/addressModel.dart';

Cords cordsFromJson(String str) => Cords.fromJson(json.decode(str));

String cordsToJson(Cords data) => json.encode(data.toJson());

class Cords {
  double? lat;
  double? lng;

  Cords({
    this.lat,
    this.lng,
  });

  factory Cords.fromJson(Map<String, dynamic> json) => Cords(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };

  factory Cords.copyFromAddress({required AddressModel data})=> Cords(lat: data.lat,lng: data.lng);
}