// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc_forecast/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  static const apiKey = '05f78a3b609f246ca14fdd3a34e71e4d';
  final http.Client _httpClient = http.Client();

  Future<Weather> getWeather(String cityName) async {
    final url = '$baseUrl?q=$cityName&appid=$apiKey&lang=tr';
    http.Response response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Hata var');
    }
    final json = jsonDecode(response.body);
    return Weather.fromMap(json);
  }
}
