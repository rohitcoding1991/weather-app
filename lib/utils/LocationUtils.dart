import 'package:location/location.dart';

import 'package:permission_handler/permission_handler.dart' as PermissionHandler;

class LocationUtils{
  static Location? _location;
  LocationUtils(){
    _location =  Location();
  }

  static Future<bool>_checkService() async{
    bool serviceEnabled = await _location!.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location!.requestService();
    }
    return serviceEnabled;
  }

  static Future<bool> hasLocationPermission() async{
    PermissionStatus status = await _checkLocationPermissionStatus();
    return status == PermissionStatus.granted || status == PermissionStatus.grantedLimited;
  }

  static Future<PermissionStatus> _checkLocationPermissionStatus() async{
    await _checkService();
    return  await _location!.hasPermission();
  }

  static Future<bool> getPermission() async{
    PermissionStatus status = await _checkLocationPermissionStatus();
    if (status == PermissionStatus.denied) {
      status = await _location!.requestPermission();

    }else if (status != PermissionStatus.granted) {
      await PermissionHandler.openAppSettings();
    }
    return status == PermissionStatus.grantedLimited || status == PermissionStatus.granted;
  }

  static Future<LocationData> getCurrentLocation() async{
    return await _location!.getLocation();
  }
}