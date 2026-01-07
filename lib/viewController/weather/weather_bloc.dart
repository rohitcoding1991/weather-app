import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/utils/AppExtensions.dart';

import '../../core/failure.dart';
import '../../model/WeatherModel.dart';
import '../../model/addressModel.dart';
import '../../model/cords.dart';
import '../../presentation/home/HomeView.dart';
import '../../presentation/location/locationOptionsView.dart';
import '../../presentation/location/searchCityView.dart';
import '../../services/repo/weatherRepo.dart';
import '../../services/storage/sharedPref.dart';
import '../../utils/DateTimeUtils.dart';
import '../../utils/LocationUtils.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  late final WeatherRepository _repo;
  Cords? _cords;

  String get appbarDate => DateTimeUtils.getCurrentTimeStamp.ddMMMyyyy;

  String  _appbarLocation = '';
  String get appbarLocation => _appbarLocation;

  List<AddressModel> searchCities = [];

  List<AddressModel> savedCities = [];

  bool citiesEditState = false;
  bool get deleteBtnEdit => savedCities.where((element) => element.selected).isNotEmpty;

  Cords? get cords => _cords;

  WeatherModel? weatherData;
  WeatherModel? currentWeatherData;
  WeatherModel? selectedHourWeatherData;

  void setAppBarLocation(AddressModel data) => _appbarLocation = data.getAddress;

  WeatherBloc({required WeatherRepository repo}) : super(WeatherInitial()) {
    _repo = repo;
    on<StartEvent>(_onStart);
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
    on<SearchCityEvent>(_onSearchCity);
    on<AddCityEvent>(_onAddCity);
    on<GetAddressByCordsEvent>(_getAddressByCords);
    on<GetAddressListSearchByName>(_getAddressListByName);
    on<ChooseCityForUpdatesEvent>(_onChooseCityForUpdates);
    on<ClearSearchCitiesEvent>(_onClearSearchCities);
    on<EditCityEvent>(_onEditCity);
    on<EditCityStateEvent>(_onEditCityState);
    on<RemoveCitiesEvent>(_onRemoveCities);
    on<GetWeatherDataEvent>(_onGetWeatherData);
    on<HourSelectEvent>(_onSelectHour);
  }






  FutureOr<void> _getAddressByCords(
      GetAddressByCordsEvent event, Emitter<WeatherState> emit) async {
    await _repo.getAddressByCords(lat: event.value.lat!, lng: event.value.lng!).then((value) {
      value.fold((l) {
        if (l is ErrorString) {
          print('someError occur ooooo' + l.error);
        } else {
          print('someError occur ooooo');
        }
      }, (address) {
        add(AddCityEvent(value: address));
      });
    });
  }

  FutureOr<void> _getAddressListByName(GetAddressListSearchByName event, Emitter<WeatherState> emit) async{
    await _repo.getAddressByName(name: event.search).then((value) {
      value.fold((l) {
        if (l is ErrorString) {
          print('someError occur' + l.error);
        } else {
          print('someError occur');
        }
      }, (r) => print('got addresss...'));
    });
  }

  FutureOr<void> _onStart(StartEvent event, Emitter<WeatherState> emit) async{
    final cords = await SharedPref.getCords();
    _cords = cords;
    if(this.cords != null ){
      SharedPref.getCities().then((value) {
        savedCities.clear();
        savedCities.addAll(value);
        int index = savedCities.indexWhere((element) => element.isCordsEqual(this.cords!));
        setAppBarLocation(savedCities[index]);
        add(GetWeatherDataEvent());
      });
    }
    emit(LauncherState(hasLocation: cords != null));
  }

  FutureOr<void> _onGetCurrentLocation(GetCurrentLocationEvent event, Emitter<WeatherState> emit) async {
    emit(const LoadingState(screenName: LocationSelectorView.name));
    final result = await _getCurrentLocation();
    result.fold((error) {
      print(error.error);
    }, (cord) {
      emit(LocationSuccessState());
      add(GetAddressByCordsEvent(value: cord));
    });
  }

  FutureOr<void> _onSearchCity(SearchCityEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherInitial());
    if(event.value.length > 2){
      await _repo.getAddressByName(name: event.value).then((value) {
        value.fold((failure){
        }, (list){
          searchCities.clear();
          searchCities.addAll(list);
          emit(const SuccessState(screenName: SearchCityView.name));
        });
      });
    }
  }

  FutureOr<void> _onAddCity(AddCityEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherInitial());
    bool cityExits = false;
    if(savedCities.isNotEmpty) cityExits =  savedCities.indexWhere((element) => element == event.value) > -1;

    if(cords == null){
      _cords = Cords.copyFromAddress(data: event.value);
      SharedPref.setCords(lat: _cords!.lat!, lng: cords!.lng!);
      if(savedCities.isEmpty){
        setAppBarLocation(event.value);
        add(GetWeatherDataEvent());
      }
    }

    if(!cityExits){
      savedCities.add(event.value);
      SharedPref.setCities(list: savedCities);
    }
    searchCities.clear();
    emit(const SuccessState(screenName: ''));
  }

  FutureOr<void> _onChooseCityForUpdates(ChooseCityForUpdatesEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherInitial());
    setAppBarLocation(event.value);
    _cords = event.value.getCords;
    SharedPref.setCords(lat: cords!.lat!, lng: cords!.lng!);
    add(GetWeatherDataEvent());
  }

  FutureOr<void> _onClearSearchCities(ClearSearchCitiesEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherInitial());
    searchCities.clear();
    emit(const SuccessState(screenName: ''));
  }

  FutureOr<void> _onEditCity(EditCityEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherInitial());
    citiesEditState = event.value;
    if(!event.value){
      for(int i = 0; i < savedCities.length; i++){
        savedCities[i].selected = false;
      }
    }
    emit(const SuccessState(screenName: ''));
  }

  FutureOr<void> _onEditCityState(EditCityStateEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherInitial());
    savedCities[event.index].selected = event.value;
    emit(const SuccessState(screenName: ''));
  }

  FutureOr<void> _onRemoveCities(RemoveCitiesEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherInitial());
    savedCities.removeWhere((element) => element.selected);
    SharedPref.setCities(list: savedCities);
    citiesEditState = false;
    emit(const SuccessState(screenName: ''));
  }

  FutureOr<void> _onGetWeatherData(GetWeatherDataEvent event, Emitter<WeatherState> emit) async{
    emit(const LoadingState(screenName: HomeView.name));
    final result = await _repo.getWeatherData(cords: cords!);
    result.fold(
            (failure) {
              emit(FailureState(screenName: HomeView.name, error: failure.error));
            },
            (data) {
              weatherData = data;
              currentWeatherData = _getCurrentDayWeatherData(data: weatherData!,index: 0);
              selectedHourWeatherData = _getSelectedHourWeatherData(data: currentWeatherData!, date: DateTime.now());
              emit(const SuccessState(screenName: HomeView.name));
            });
  }

  FutureOr<void> _onSelectHour(HourSelectEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherInitial());
    final date = currentWeatherData!.hourly!.time![event.index].yyyy_MM_ddTHH_mm;
    selectedHourWeatherData = _getSelectedHourWeatherData(data: currentWeatherData!, date: date);
    emit(const SuccessState(screenName: ''));
  }
}

Future <Either<ErrorString, Cords>> _getCurrentLocation() async{
  bool status = false;
  if (!(await LocationUtils.hasLocationPermission())) {
    await LocationUtils.getPermission();
    status = await LocationUtils.hasLocationPermission();
  } else {
    status = true;
  }

  if (status) {
    final location = await LocationUtils.getCurrentLocation();
    return Right(Cords(lat: location.latitude,lng: location.longitude));
  } else {
    return const Left(ErrorString(error: 'location permission not granted'));
  }
}


WeatherModel _getCurrentDayWeatherData({required WeatherModel data, required int index}){
  final hourly = data.hourly!;

  final timeList = hourly.time ?? [];
  final weatherCodeList = hourly.weathercode ?? [];
  final tempList = hourly.temperature2M ?? [];
  final humidityList = hourly.relativehumidity2M ?? [];
  final windList = hourly.windspeed10M ?? [];
  final apparentTempList = hourly.apparentTemperature ?? [];
  final pressureList = hourly.surfacePressure ?? [];

  final Daily daily = data.daily!;
  final DateTime date = daily.time![index];

  List<int> indexList = [];

  for(int i = 0; i < timeList.length; i++){
    if(timeList[i].yyyy_MM_ddTHH_mm.ddMMyyyy.isEquals(date.ddMMyyyy)) indexList.add(i);
  }

  final result = WeatherModel(
    hourly: Hourly(
      time: indexList.map((e) => timeList[e]).toList(),
      weathercode: indexList.map((e) => weatherCodeList[e]).toList(),
      temperature2M:  indexList.map((e) => tempList[e]).toList(),
      relativehumidity2M: indexList.map((e) => humidityList[e]).toList(),
      windspeed10M: indexList.map((e) => windList[e]).toList(),
      apparentTemperature: indexList.map((e) => apparentTempList[e]).toList(),
        surfacePressure: indexList.map((e) => pressureList[e]).toList()
    ),
    hourlyUnits: HourlyUnits(),
    daily: Daily(
      sunrise: [daily.sunrise![index]],
      sunset: [daily.sunset![index]]
    )
  );
  return result;

}

WeatherModel? _getSelectedHourWeatherData({required WeatherModel data, required DateTime date}){
  final hourly = data.hourly!;
  final hourList = hourly.time?? [];

  final index = hourList.indexWhere((element){
    final dateTime= element.yyyy_MM_ddTHH_mm;
    final result = dateTime.isAtSameMomentAs(date) || (dateTime.isBefore(date) && date.difference(dateTime) < const Duration(hours: 1));
    return result;
  });

  if(index > -1){
    final weatherCodeList = hourly.weathercode?? [];
    final tempList = hourly.temperature2M ?? [];
    final humidityList = hourly.relativehumidity2M ?? [];
    final windList = hourly.windspeed10M ?? [];
    final apparentTempList = hourly.apparentTemperature ?? [];
    final pressureList = hourly.surfacePressure ?? [];

    return WeatherModel(
      hourly: Hourly(
        time: [hourList[index]],
        temperature2M: [tempList[index]],
        weathercode: [weatherCodeList[index]],
        relativehumidity2M: [humidityList[index]],
        windspeed10M: [windList[index]],
        apparentTemperature: [apparentTempList[index]],
        surfacePressure: [pressureList[index]]
      ),
      daily: data.daily
    );
  }else{
    return null;
  }
}