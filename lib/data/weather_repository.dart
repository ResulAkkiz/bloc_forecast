import 'package:bloc_forecast/data/weather_api_client.dart';
import 'package:bloc_forecast/locator/locator.dart';
import 'package:bloc_forecast/models/weather_model.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator.get<WeatherApiClient>();
  Future<Weather> getWeather(String cityName) async {
    return await weatherApiClient.getWeather(cityName);
  }
}
