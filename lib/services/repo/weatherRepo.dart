import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../../model/WeatherModel.dart';
import '../../model/addressModel.dart';
import '../../model/cords.dart';
import '../Api/apiService.dart';

abstract class WeatherRepository{
  Future<Either<Failure,AddressModel>> getAddressByCords({required double lat, required double lng});
  Future<Either<Failure,List<AddressModel>>> getAddressByName({required String name});
  Future<Either<ErrorString,WeatherModel>> getWeatherData({required Cords cords});
}

class WeatherRepoImpl extends WeatherRepository{
  final ApiService _service;

  WeatherRepoImpl({required ApiService service}) : _service = service;

  @override
  Future<Either<Failure, AddressModel>> getAddressByCords({required double lat, required double lng}) async{
    try{
      final response = await _service.getAddressByCords(lat, lng);
      final map = jsonDecode(response.bodyString) as Map<String,dynamic>;
      if(response.isSuccessful){
        final obj = AddressModel.fromJson_Cord(map);
        return Right(obj);
      }else{
        return Left(ErrorString(error: map['error']['message']));
      }
    }catch(e){
      return Left(ErrorString(error: 'expection :: '+e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddressByName({required String name}) async{
    try{
      final response = await _service.getAddressByName(name);
      final data = jsonDecode(response.bodyString) as Map<String,dynamic>;
       if(response.isSuccessful){
        final list = data['results'] ?? [];
        final obj = List<AddressModel>.from(list.map((json)=> AddressModel.fromJson_Name(json)));
        return Right(obj);
      }else{
        return Left(ErrorString(error: response.bodyString));
      }
    }catch(e){
      return Left(ErrorString(error: 'expection :: '+e.toString()));
    }
  }

  @override
  Future<Either<ErrorString, WeatherModel>> getWeatherData({required Cords cords}) async{
    try{
      final response = await _service.getWeatherData(cords.lat!, cords.lng!);
      final data = jsonDecode(response.bodyString) as Map<String,dynamic>;
      if(response.isSuccessful){
        return Right(WeatherModel.fromJson(data));
      }else{
        return Left(ErrorString(error: data['reason']));
      }
    }catch(e){
      print(e);
      return Left(ErrorString(error: 'expection :: '+e.toString()));
    }
  }
}