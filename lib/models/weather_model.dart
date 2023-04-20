// To parse this JSON data, do
//
//     final weather = weatherFromMap(jsonString);

import 'dart:convert';

Weather weatherFromMap(String str) => Weather.fromMap(json.decode(str));

String weatherToMap(Weather data) => json.encode(data.toMap());

class Weather {
  Weather({
    this.weather,
    this.main,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  List<WeatherElement>? weather;
  Main? main;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromMap(x))),
        main: Main.fromMap(json["main"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toMap() => {
        "weather": List<dynamic>.from(
            weather != null ? weather!.map((x) => x.toMap()) : []),
        "main": main != null ? main!.toMap() : null,
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class WeatherElement {
  WeatherElement({
    required this.id,
    this.main,
    this.description,
    this.icon,
  });

  int id;
  String? main;
  String? description;
  String? icon;

  factory WeatherElement.fromMap(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
