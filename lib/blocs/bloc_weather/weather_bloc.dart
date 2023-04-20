import 'package:bloc_forecast/data/weather_repository.dart';
import 'package:bloc_forecast/locator/locator.dart';
import 'package:bloc_forecast/models/weather_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = locator.get<WeatherRepository>();
  WeatherBloc() : super(InitialWeatherState()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(LoadingWeatherState());
      try {
        final Weather weather =
            await weatherRepository.getWeather(event.cityName);
        emit(LoadedWeatherState(weather: weather));
      } catch (e) {
        emit(ErrorWeatherState());
      }
    });

    on<RefreshWeatherEvent>((event, emit) async {
      try {
        final Weather weather =
            await weatherRepository.getWeather(event.cityName);
        emit(LoadedWeatherState(weather: weather));
      } catch (e) {
        emit(state); //if error exist,show current state in screen
      }
    });
  }
}
