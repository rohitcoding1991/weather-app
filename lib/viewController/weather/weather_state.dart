part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}


class LauncherState extends WeatherState {
  final bool hasLocation;

  const LauncherState({required this.hasLocation});
  @override
  List<Object> get props => [hasLocation];
}

class LoadingState extends WeatherState {
  final String screenName;

  const LoadingState({required this.screenName});

  @override
  List<Object?> get props => [screenName];
}

class SuccessState extends WeatherState{
  final String screenName;
  const SuccessState({required this.screenName});
  @override
  List<Object?> get props => [screenName];
}

class FailureState extends WeatherState{
  final String screenName;
  final String error;
  const FailureState({required this.screenName, required this.error});
  @override
  List<Object?> get props => [screenName,error];
}


class LocationSuccessState extends WeatherState {
  @override
  List<Object> get props => [];
}
