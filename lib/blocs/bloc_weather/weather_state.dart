part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitialWeatherState extends WeatherState {}

class LoadingWeatherState extends WeatherState {}

class LoadedWeatherState extends WeatherState {
  final Weather weather;
  const LoadedWeatherState({
    required this.weather,
  });

  @override
  List<Object> get props => [weather];
}

class ErrorWeatherState extends WeatherState {}
