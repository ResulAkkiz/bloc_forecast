import 'dart:developer';

import 'package:bloc_forecast/blocs/bloc_theme/theme_bloc.dart';
import 'package:bloc_forecast/blocs/bloc_weather/weather_bloc.dart';
import 'package:bloc_forecast/extension/heat_transform_extension.dart';
import 'package:bloc_forecast/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('Homepage build oldu');
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: BlocBuilder(
            bloc: weatherBloc,
            builder: (context, state) {
              if (state is InitialWeatherState) {
                log('state is InitialWeatherState');
                return InitialWeatherScreen(
                    cityController: cityController, weatherBloc: weatherBloc);
              }
              if (state is LoadingWeatherState) {
                log('state is LoadingWeatherState');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LoadedWeatherState) {
                final themeBloc = BlocProvider.of<ThemeBloc>(context);

                log('state is LoadedWeatherState');
                final weather = state.weather;
                themeBloc.add(ChangeThemeEvent(
                    weatherDesc: weather.weather!.first.description!));
                return RefreshIndicator(
                    onRefresh: () async {
                      weatherBloc.add(
                          RefreshWeatherEvent(cityName: cityController.text));
                    },
                    child: LoadedWeatherScreen(
                        weather: weather,
                        cityController: cityController,
                        weatherBloc: weatherBloc));
              }
              if (state is ErrorWeatherState) {
                log('state is ErrorWeatherState');
                return ErrorWeatherScreen(
                    cityController: cityController, weatherBloc: weatherBloc);
              }
              return const SizedBox();
            },
          ),
        ));
  }
}

class InitialWeatherScreen extends StatelessWidget {
  const InitialWeatherScreen({
    super.key,
    required this.cityController,
    required this.weatherBloc,
  });

  final TextEditingController cityController;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            color: Colors.black45, borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cityController,
            ),
            ElevatedButton(
                onPressed: () {
                  weatherBloc
                      .add(FetchWeatherEvent(cityName: cityController.text));
                },
                child: const Text('Yeni Şehir Getir')),
          ],
        ),
      ),
    );
  }
}

class ErrorWeatherScreen extends StatelessWidget {
  const ErrorWeatherScreen({
    super.key,
    required this.cityController,
    required this.weatherBloc,
  });

  final TextEditingController cityController;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Hata oluştu, lütfen bir şehir giriniz.'),
        Container(
          margin: const EdgeInsets.all(18.0),
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            children: [
              TextField(
                controller: cityController,
              ),
              ElevatedButton(
                  onPressed: () {
                    weatherBloc
                        .add(FetchWeatherEvent(cityName: cityController.text));
                  },
                  child: const Text('Yeni Şehir Getir')),
            ],
          ),
        ),
      ],
    );
  }
}

class LoadedWeatherScreen extends StatelessWidget {
  const LoadedWeatherScreen({
    super.key,
    required this.weather,
    required this.cityController,
    required this.weatherBloc,
  });

  final Weather weather;
  final TextEditingController cityController;
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.3),
              minRadius: 34,
              child: Image.network(
                  "https://openweathermap.org/img/wn/${weather.weather!.first.icon}@4x.png"),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              weather.weather!.first.description!.toUpperCase(),
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 25,
              direction: Axis.horizontal,
              children: [
                Chip(
                    label: Text(
                        'Sıcaklık: ${(weather.main!.temp)?.kelvinToCelsius}')),
                Chip(
                    label: Text(
                        'Min Sıcaklık: ${(weather.main!.tempMin)?.kelvinToCelsius}')),
                Chip(
                    label: Text(
                        'Max Sıcaklık: ${(weather.main!.tempMax)?.kelvinToCelsius}')),
                Chip(
                    label: Text(
                        'Hissedilen Sıcaklık: ${(weather.main!.feelsLike)?.kelvinToCelsius}')),
                Chip(label: Text('Nem: %${(weather.main!.humidity)}')),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: cityController,
                  ),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            weatherBloc.add(FetchWeatherEvent(
                                cityName: cityController.text));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: state.color),
                          child: const Text('Yeni Şehir Getir'));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
