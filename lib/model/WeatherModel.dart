// To parse this JSON data, do
//
//     final weatherData = weatherDataFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  num? latitude;
  num? longitude;
  num? generationtimeMs;
  num? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  num? elevation;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.hourlyUnits,
    this.hourly,
    this.dailyUnits,
    this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    latitude: intoNum(json["latitude"]),
    longitude: intoNum(json["longitude"]),
    generationtimeMs: intoNum(json["generationtime_ms"]),
    utcOffsetSeconds: json["utc_offset_seconds"],
    timezone: json["timezone"],
    timezoneAbbreviation: json["timezone_abbreviation"],
    elevation: json["elevation"],
    hourlyUnits: json["hourly_units"] == null ? null : HourlyUnits.fromJson(json["hourly_units"]),
    hourly: json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]),
    dailyUnits: json["daily_units"] == null ? null : DailyUnits.fromJson(json["daily_units"]),
    daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "hourly_units": hourlyUnits?.toJson(),
    "hourly": hourly?.toJson(),
    "daily_units": dailyUnits?.toJson(),
    "daily": daily?.toJson(),
  };
}

class Daily {
  List<DateTime>? time;
  List<num?>? weathercode;
  List<num?>? temperature2MMax;
  List<num?>? temperature2MMin;
  List<num?>? apparentTemperatureMax;
  List<num?>? apparentTemperatureMin;
  List<String>? sunrise;
  List<String>? sunset;
  List<num?>? precipitationSum;
  List<num?>? precipitationProbabilityMax;
  List<num?>? windspeed10MMax;
  List<num?>? windgusts10MMax;
  List<num?>? uvIndexMax;
  List<num?>? rainSum;
  List<num?>? winddirection10MDominant;

  Daily({
    this.time,
    this.weathercode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.apparentTemperatureMax,
    this.apparentTemperatureMin,
    this.sunrise,
    this.sunset,
    this.precipitationSum,
    this.precipitationProbabilityMax,
    this.windspeed10MMax,
    this.windgusts10MMax,
    this.uvIndexMax,
    this.rainSum,
    this.winddirection10MDominant,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    time: json["time"] == null ? [] : List<DateTime>.from(json["time"]!.map((x) => DateTime.parse(x))),
    weathercode: json["weathercode"] == null ? [] : List<num?>.from(json["weathercode"]!.map((x) => intoNum(x))),
    temperature2MMax: json["temperature_2m_max"] == null ? [] : List<num?>.from(json["temperature_2m_max"]!.map((x) => intoNum(x))),
    temperature2MMin: json["temperature_2m_min"] == null ? [] : List<num?>.from(json["temperature_2m_min"]!.map((x) => intoNum(x))),
    apparentTemperatureMax: json["apparent_temperature_max"] == null ? [] : List<num?>.from(json["apparent_temperature_max"]!.map((x) => intoNum(x))),
    apparentTemperatureMin: json["apparent_temperature_min"] == null ? [] : List<num?>.from(json["apparent_temperature_min"]!.map((x) => intoNum(x))),
    sunrise: json["sunrise"] == null ? [] : List<String>.from(json["sunrise"]!.map((x) => x)),
    sunset: json["sunset"] == null ? [] : List<String>.from(json["sunset"]!.map((x) => x)),
    precipitationSum: json["precipitation_sum"] == null ? [] : List<num?>.from(json["precipitation_sum"]!.map((x) => intoNum(x))),
    precipitationProbabilityMax: json["precipitation_probability_max"] == null ? [] : List<num?>.from(json["precipitation_probability_max"]!.map((x) => intoNum(x))),
    windspeed10MMax: json["windspeed_10m_max"] == null ? [] : List<num?>.from(json["windspeed_10m_max"]!.map((x) => intoNum(x))),
    windgusts10MMax: json["windgusts_10m_max"] == null ? [] : List<num?>.from(json["windgusts_10m_max"]!.map((x) => intoNum(x))),
    uvIndexMax: json["uv_index_max"] == null ? [] : List<num?>.from(json["uv_index_max"]!.map((x) => intoNum(x))),
    rainSum: json["rain_sum"] == null ? [] : List<num?>.from(json["rain_sum"]!.map((x) => intoNum(x))),
    winddirection10MDominant: json["winddirection_10m_dominant"] == null ? [] : List<num?>.from(json["winddirection_10m_dominant"]!.map((x) => intoNum(x))),
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? [] : List<dynamic>.from(time!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "weathercode": weathercode == null ? [] : List<dynamic>.from(weathercode!.map((x) => x)),
    "temperature_2m_max": temperature2MMax == null ? [] : List<dynamic>.from(temperature2MMax!.map((x) => x)),
    "temperature_2m_min": temperature2MMin == null ? [] : List<dynamic>.from(temperature2MMin!.map((x) => x)),
    "apparent_temperature_max": apparentTemperatureMax == null ? [] : List<dynamic>.from(apparentTemperatureMax!.map((x) => x)),
    "apparent_temperature_min": apparentTemperatureMin == null ? [] : List<dynamic>.from(apparentTemperatureMin!.map((x) => x)),
    "sunrise": sunrise == null ? [] : List<dynamic>.from(sunrise!.map((x) => x)),
    "sunset": sunset == null ? [] : List<dynamic>.from(sunset!.map((x) => x)),
    "precipitation_sum": precipitationSum == null ? [] : List<dynamic>.from(precipitationSum!.map((x) => x)),
    "precipitation_probability_max": precipitationProbabilityMax == null ? [] : List<dynamic>.from(precipitationProbabilityMax!.map((x) => x)),
    "windspeed_10m_max": windspeed10MMax == null ? [] : List<dynamic>.from(windspeed10MMax!.map((x) => x)),
    "windgusts_10m_max": windgusts10MMax == null ? [] : List<dynamic>.from(windgusts10MMax!.map((x) => x)),
    "uv_index_max": uvIndexMax == null ? [] : List<dynamic>.from(uvIndexMax!.map((x) => x)),
    "rain_sum": rainSum == null ? [] : List<dynamic>.from(rainSum!.map((x) => x)),
    "winddirection_10m_dominant": winddirection10MDominant == null ? [] : List<dynamic>.from(winddirection10MDominant!.map((x) => x)),
  };
}

class DailyUnits {
  String? time;
  String? weathercode;
  String? temperature2MMax;
  String? temperature2MMin;
  String? apparentTemperatureMax;
  String? apparentTemperatureMin;
  String? sunrise;
  String? sunset;
  String? precipitationSum;
  String? precipitationProbabilityMax;
  String? windspeed10MMax;
  String? windgusts10MMax;
  String? uvIndexMax;
  String? rainSum;
  String? winddirection10MDominant;

  DailyUnits({
    this.time,
    this.weathercode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.apparentTemperatureMax,
    this.apparentTemperatureMin,
    this.sunrise,
    this.sunset,
    this.precipitationSum,
    this.precipitationProbabilityMax,
    this.windspeed10MMax,
    this.windgusts10MMax,
    this.uvIndexMax,
    this.rainSum,
    this.winddirection10MDominant,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
    time: json["time"],
    weathercode: json["weathercode"],
    temperature2MMax: json["temperature_2m_max"],
    temperature2MMin: json["temperature_2m_min"],
    apparentTemperatureMax: json["apparent_temperature_max"],
    apparentTemperatureMin: json["apparent_temperature_min"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    precipitationSum: json["precipitation_sum"],
    precipitationProbabilityMax: json["precipitation_probability_max"],
    windspeed10MMax: json["windspeed_10m_max"],
    windgusts10MMax: json["windgusts_10m_max"],
    uvIndexMax: json["uv_index_max"],
    rainSum: json["rain_sum"],
    winddirection10MDominant: json["winddirection_10m_dominant"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "weathercode": weathercode,
    "temperature_2m_max": temperature2MMax,
    "temperature_2m_min": temperature2MMin,
    "apparent_temperature_max": apparentTemperatureMax,
    "apparent_temperature_min": apparentTemperatureMin,
    "sunrise": sunrise,
    "sunset": sunset,
    "precipitation_sum": precipitationSum,
    "precipitation_probability_max": precipitationProbabilityMax,
    "windspeed_10m_max": windspeed10MMax,
    "windgusts_10m_max": windgusts10MMax,
    "uv_index_max": uvIndexMax,
    "rain_sum": rainSum,
    "winddirection_10m_dominant": winddirection10MDominant,
  };
}

class Hourly {
  List<String>? time;
  List<num?>? temperature2M;
  List<num?>? relativehumidity2M;
  List<num?>? apparentTemperature;
  List<num?>? precipitation;
  List<num?>? rain;
  List<num?>? weathercode;
  List<num?>? surfacePressure;
  List<num?>? visibility;
  List<num?>? evapotranspiration;
  List<num?>? windspeed10M;
  List<num?>? winddirection10M;
  List<num?>? windgusts10M;
  List<num?>? cloudcover;
  List<num?>? uvIndex;
  List<num?>? dewpoint2M;
  List<num?>? precipitationProbability;
  List<num?>? shortwaveRadiation;

  Hourly({
    this.time,
    this.temperature2M,
    this.relativehumidity2M,
    this.apparentTemperature,
    this.precipitation,
    this.rain,
    this.weathercode,
    this.surfacePressure,
    this.visibility,
    this.evapotranspiration,
    this.windspeed10M,
    this.winddirection10M,
    this.windgusts10M,
    this.cloudcover,
    this.uvIndex,
    this.dewpoint2M,
    this.precipitationProbability,
    this.shortwaveRadiation,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    time: json["time"] == null ? [] : List<String>.from(json["time"]!.map((x) => x)),
    temperature2M: json["temperature_2m"] == null ? [] : List<num?>.from(json["temperature_2m"]!.map((x) => intoNum(x))),
    relativehumidity2M: json["relativehumidity_2m"] == null ? [] : List<num?>.from(json["relativehumidity_2m"]!.map((x) => intoNum(x))),
    apparentTemperature: json["apparent_temperature"] == null ? [] : List<num?>.from(json["apparent_temperature"]!.map((x) => intoNum(x))),
    precipitation: json["precipitation"] == null ? [] : List<num?>.from(json["precipitation"]!.map((x) => intoNum(x))),
    rain: json["rain"] == null ? [] : List<num?>.from(json["rain"]!.map((x) => intoNum(x))),
    weathercode: json["weathercode"] == null ? [] : List<num?>.from(json["weathercode"]!.map((x) => intoNum(x))),
    surfacePressure: json["surface_pressure"] == null ? [] : List<num?>.from(json["surface_pressure"]!.map((x) => intoNum(x))),
    visibility: json["visibility"] == null ? [] : List<num?>.from(json["visibility"]!.map((x) => intoNum(x))),
    evapotranspiration: json["evapotranspiration"] == null ? [] : List<num?>.from(json["evapotranspiration"]!.map((x) => intoNum(x))),
    windspeed10M: json["windspeed_10m"] == null ? [] : List<num?>.from(json["windspeed_10m"]!.map((x) => intoNum(x))),
    winddirection10M: json["winddirection_10m"] == null ? [] : List<num?>.from(json["winddirection_10m"]!.map((x) => intoNum(x))),
    windgusts10M: json["windgusts_10m"] == null ? [] : List<num?>.from(json["windgusts_10m"]!.map((x) => intoNum(x))),
    cloudcover: json["cloudcover"] == null ? [] : List<num?>.from(json["cloudcover"]!.map((x) => intoNum(x))),
    uvIndex: json["uv_index"] == null ? [] : List<num?>.from(json["uv_index"]!.map((x) => intoNum(x))),
    dewpoint2M: json["dewpoint_2m"] == null ? [] : List<num?>.from(json["dewpoint_2m"]!.map((x) => intoNum(x))),
    precipitationProbability: json["precipitation_probability"] == null ? [] : List<num?>.from(json["precipitation_probability"]!.map((x) => intoNum(x))),
    shortwaveRadiation: json["shortwave_radiation"] == null ? [] : List<num?>.from(json["shortwave_radiation"]!.map((x) => intoNum(x)))
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? [] : List<dynamic>.from(time!.map((x) => x)),
    "temperature_2m": temperature2M == null ? [] : List<dynamic>.from(temperature2M!.map((x) => x)),
    "relativehumidity_2m": relativehumidity2M == null ? [] : List<dynamic>.from(relativehumidity2M!.map((x) => x)),
    "apparent_temperature": apparentTemperature == null ? [] : List<dynamic>.from(apparentTemperature!.map((x) => x)),
    "precipitation": precipitation == null ? [] : List<dynamic>.from(precipitation!.map((x) => x)),
    "rain": rain == null ? [] : List<dynamic>.from(rain!.map((x) => x)),
    "weathercode": weathercode == null ? [] : List<dynamic>.from(weathercode!.map((x) => x)),
    "surface_pressure": surfacePressure == null ? [] : List<dynamic>.from(surfacePressure!.map((x) => x)),
    "visibility": visibility == null ? [] : List<dynamic>.from(visibility!.map((x) => x)),
    "evapotranspiration": evapotranspiration == null ? [] : List<dynamic>.from(evapotranspiration!.map((x) => x)),
    "windspeed_10m": windspeed10M == null ? [] : List<dynamic>.from(windspeed10M!.map((x) => x)),
    "winddirection_10m": winddirection10M == null ? [] : List<dynamic>.from(winddirection10M!.map((x) => x)),
    "windgusts_10m": windgusts10M == null ? [] : List<dynamic>.from(windgusts10M!.map((x) => x)),
    "cloudcover": cloudcover == null ? [] : List<dynamic>.from(cloudcover!.map((x) => x)),
    "uv_index": uvIndex == null ? [] : List<dynamic>.from(uvIndex!.map((x) => x)),
    "dewpoint_2m": dewpoint2M == null ? [] : List<dynamic>.from(dewpoint2M!.map((x) => x)),
    "precipitation_probability": precipitationProbability == null ? [] : List<dynamic>.from(precipitationProbability!.map((x) => x)),
    "shortwave_radiation": shortwaveRadiation == null ? [] : List<dynamic>.from(shortwaveRadiation!.map((x) => x)),
  };
}

class HourlyUnits {
  String? time;
  String? temperature2M;
  String? relativehumidity2M;
  String? apparentTemperature;
  String? precipitation;
  String? rain;
  String? weathercode;
  String? surfacePressure;
  String? visibility;
  String? evapotranspiration;
  String? windspeed10M;
  String? winddirection10M;
  String? windgusts10M;
  String? cloudcover;
  String? uvIndex;
  String? dewpoint2M;
  String? precipitationProbability;
  String? shortwaveRadiation;

  HourlyUnits({
    this.time,
    this.temperature2M,
    this.relativehumidity2M,
    this.apparentTemperature,
    this.precipitation,
    this.rain,
    this.weathercode,
    this.surfacePressure,
    this.visibility,
    this.evapotranspiration,
    this.windspeed10M,
    this.winddirection10M,
    this.windgusts10M,
    this.cloudcover,
    this.uvIndex,
    this.dewpoint2M,
    this.precipitationProbability,
    this.shortwaveRadiation,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
    time: json["time"],
    temperature2M: json["temperature_2m"],
    relativehumidity2M: json["relativehumidity_2m"],
    apparentTemperature: json["apparent_temperature"],
    precipitation: json["precipitation"],
    rain: json["rain"],
    weathercode: json["weathercode"],
    surfacePressure: json["surface_pressure"],
    visibility: json["visibility"],
    evapotranspiration: json["evapotranspiration"],
    windspeed10M: json["windspeed_10m"],
    winddirection10M: json["winddirection_10m"],
    windgusts10M: json["windgusts_10m"],
    cloudcover: json["cloudcover"],
    uvIndex: json["uv_index"],
    dewpoint2M: json["dewpoint_2m"],
    precipitationProbability: json["precipitation_probability"],
    shortwaveRadiation: json["shortwave_radiation"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "temperature_2m": temperature2M,
    "relativehumidity_2m": relativehumidity2M,
    "apparent_temperature": apparentTemperature,
    "precipitation": precipitation,
    "rain": rain,
    "weathercode": weathercode,
    "surface_pressure": surfacePressure,
    "visibility": visibility,
    "evapotranspiration": evapotranspiration,
    "windspeed_10m": windspeed10M,
    "winddirection_10m": winddirection10M,
    "windgusts_10m": windgusts10M,
    "cloudcover": cloudcover,
    "uv_index": uvIndex,
    "dewpoint_2m": dewpoint2M,
    "precipitation_probability": precipitationProbability,
    "shortwave_radiation": shortwaveRadiation,
  };
}

num? intoNum(dynamic value){
  num? result;
  if(value == null){
    result = null;
  } else if(value is String){
    result =  num.parse(value);
  }else if (value is double || value is int){
    result = value;
  }
  return result;
}
