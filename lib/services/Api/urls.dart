
class UrlKeys{
  static const String lat = 'lat';
  static const String lng = 'lng';
  static const String name = 'name';
}


class Urls{
  static const String baseUrl = 'https://api.open-meteo.com/v1';
  static const String getWeatherData = '/forecast?'
      'latitude={${UrlKeys.lat}}'
      '&longitude={${UrlKeys.lng}}'
      '&hourly=temperature_2m,relativehumidity_2m,apparent_temperature,precipitation,rain,weathercode,surface_pressure,visibility,evapotranspiration,windspeed_10m,winddirection_10m,windgusts_10m,cloudcover,uv_index,dewpoint_2m,precipitation_probability,shortwave_radiation&daily=weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,precipitation_sum,precipitation_probability_max,windspeed_10m_max,windgusts_10m_max,uv_index_max,rain_sum,winddirection_10m_dominant&forecast_days=7&timezone=auto';



  static const String openStreetBaseUrl = 'https://nominatim.openstreetmap.org';
  static const String getAddressByCords = '$openStreetBaseUrl/reverse?lat={${UrlKeys.lat}}&lon={${UrlKeys.lng}}&format=json';
  static const String getAddressByName = 'https://geocoding-api.open-meteo.com/v1/search?name={${UrlKeys.name}}&format=json';
}