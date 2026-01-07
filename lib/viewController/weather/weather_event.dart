part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetAddressByCordsEvent extends WeatherEvent{
  final Cords value;

  const GetAddressByCordsEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class GetAddressListSearchByName extends WeatherEvent{
  final String search;

  const GetAddressListSearchByName({required this.search});
  @override
  List<Object?> get props => [search];
}


class StartEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}


class GetCurrentLocationEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}

class SearchCityEvent extends WeatherEvent{
  final String value;

  const SearchCityEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class AddCityEvent extends WeatherEvent{
  final AddressModel value;

  const AddCityEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class ChooseCityForUpdatesEvent extends WeatherEvent{
  final AddressModel value;

  const ChooseCityForUpdatesEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class ClearSearchCitiesEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}

class EditCityEvent extends WeatherEvent{
  final bool value;

  const EditCityEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class EditCityStateEvent extends WeatherEvent{
  final int index;
  final bool value;

  const EditCityStateEvent( {required this.value,required this.index,});

  @override
  List<Object?> get props => [value, index];
}

class RemoveCitiesEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}

class GetWeatherDataEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}


class HourSelectEvent extends WeatherEvent{
  final int index;

  const HourSelectEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

