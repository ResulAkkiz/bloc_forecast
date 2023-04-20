import 'package:bloc_forecast/blocs/bloc_theme/theme_bloc.dart';
import 'package:bloc_forecast/blocs/bloc_weather/weather_bloc.dart';
import 'package:bloc_forecast/locator/locator.dart';
import 'package:bloc_forecast/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(color: state.color),
              primaryColor: state.color),
          home: const Homepage(),
        ),
      ),
    );
  }
}
