import 'dart:convert';

import 'package:weather_app/utils/AppExtensions.dart';

import 'cords.dart';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());


class AddressModel {
  String? city;
  String? distt;
  String? state;
  String? country;
  double? lat;
  double? lng;
  bool selected;

  AddressModel({
    this.city,
    this.distt,
    this.state,
    this.country,
    this.lat,
    this.lng,
    this.selected = false
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    city: json["city"],
    distt: json["distt"],
    state: json["state"],
    country: json["country"],
    lat: json["lat"],
    lng: json["lng"],
  );

  // when data fetch from getAddressByCords
  factory AddressModel.fromJson_Cord(Map<String, dynamic> json) {
    final address = json['address'];
    return AddressModel(
      city: address["town"],
      distt: address["state_district"],
      state: address["state"],
      country: address["country"],
      lat: json["lat"] != null ? (json["lat"] is String ? double.parse(json['lat']) : json["lat"]): null,
      lng: json["lon"] != null ? (json["lon"] is String ? double.parse(json['lon']) : json["lon"]): null,
    );
  }

  // when data fetch from search city by name
  factory AddressModel.fromJson_Name(Map<String, dynamic> json) => AddressModel(
      city: json["name"],
      distt: json["admin2"],
      state: json["admin1"],
      country: json["country"],
      lat: json["latitude"],
      lng: json["longitude"],
    );


  Map<String, dynamic> toJson() => {
    "city": city,
    "distt": distt,
    "state": state,
    "country": country,
    "lat": lat,
    "lng": lng,
  };


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.city == city &&
        other.distt == distt &&
        other.state == state &&
        other.country == country &&
        other.lat == lat &&
        other.lng == lng;
  }

  bool  isCordsEqual(Cords cords) => cords.lat == lat && cords.lng == lng;

  Cords get getCords => Cords(lat: lat, lng: lng);

  @override
  int get hashCode {
    return city.hashCode ^
    distt.hashCode ^
    state.hashCode ^
    country.hashCode ^
    lat.hashCode ^
    lng.hashCode;
  }
}


extension addressExt on AddressModel{
  String get getAddress => '${city ?? ''}, ${distt ?? ''}, ${state ?? ''}, $country'.filterAddress;
}


