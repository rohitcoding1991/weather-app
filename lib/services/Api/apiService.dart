import 'package:chopper/chopper.dart';
import 'package:weather_app/services/Api/urls.dart';

part 'apiService.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(Urls.baseUrl),
      services: [_$ApiService()],
      converter: const JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Get(path: Urls.getAddressByCords)
  Future<Response> getAddressByCords(
    @Path(UrlKeys.lat) final num lat,
    @Path(UrlKeys.lng) final num lng,
  );

  @Get(path: Urls.getAddressByName)
  Future<Response> getAddressByName(
      @Path(UrlKeys.name) final String name
      );

  @Get(path: Urls.getWeatherData)
  Future<Response> getWeatherData(
      @Path(UrlKeys.lat) final double lat,
      @Path(UrlKeys.lng) final double lng,
      );
}
