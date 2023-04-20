import 'package:bloc_forecast/data/weather_api_client.dart';
import 'package:bloc_forecast/data/weather_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

//Uygulama başlar başlamaz, nesne üretimi olmuyor.Lazy olduğu için ihtiyaç duyulduğu an üretiliyor.
void setupLocator() {
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
  // locator.registerFactory(
  //     () => WeatherRepository()); // Herseferinde yeni nesne üretilir.
}
