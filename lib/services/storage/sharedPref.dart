import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants/AppStrings.dart';
import '../../model/addressModel.dart';
import '../../model/cords.dart';
import 'AppData.dart';

class SharedPref {
  static const String _cordsKey = 'cordsKey_${AppStrings.appName}';
  static const String _cityListKey = 'cityListKey_${AppStrings.appName}';

  static late SharedPreferences _pref;

  Future init() async {
    _pref = await SharedPreferences.getInstance();
    return;
  }

  static setCords({required double lat, required double lng}) async {
    final cords = Cords(lat: lat, lng: lng);
    await _setMap(key: _cordsKey, value: cords.toJson());
    AppData.cords = cords;
  }

  static Future<Cords?> getCords() async {
    final value = await _getMap(key: _cordsKey);
    Cords? cords;
    if (value != null) {
      cords = Cords.fromJson(value);
    }
    AppData.cords = cords;
    return cords;
  }

  static setCities({required List<AddressModel> list}){
    _setList(key: _cityListKey, list: list);
  }

  static Future<List<AddressModel>> getCities() async{
    final list = await _getList(key: _cityListKey);
    return List<AddressModel>.from(list.map((json) => AddressModel.fromJson(json)));
  }

  static _setMap({required String key,required Map<String,dynamic> value}) => _pref.setMap(key, value);

  static Future<Map<String, dynamic>?> _getMap({required String key}) async => _pref.getMap(key);

  static _setList({required String key, required List list}) => _pref.setList(key, list);
  static Future<List<dynamic>>_getList({required String key}) => _pref.getList(key);
}


extension PrefExtn on SharedPreferences{
  void setList(String key, List value){
    setString(key, jsonEncode(value));
  }

  Future<List> getList(String key) async{
    String? data = await getString(key);
    final list = data != null ? jsonDecode(data) : [];
    return list;
  }

  void setMap(String key, Map<String, dynamic> value){
    setString(key,jsonEncode(value));
  }

  Future<Map<String, dynamic>?> getMap(String key) async{
    String? data = await getString(key);
    return data == null ? null : jsonDecode(data) as Map<String, dynamic>;
  }
}
