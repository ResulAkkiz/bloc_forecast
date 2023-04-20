import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeInitial(color: Colors.red, theme: ThemeData.light())) {
    on<ChangeThemeEvent>((event, emit) {
      ThemeValueState themeState;

      switch (event.weatherDesc.toLowerCase()) {
        case 'kapalı':
          themeState = ThemeValueState(
              theme: ThemeData(primaryColor: Colors.grey), color: Colors.grey);
          break;
        case 'açık':
          themeState = ThemeValueState(
              theme: ThemeData(primaryColor: Colors.red), color: Colors.red);
          break;
        case 'parçalı bulutlu':
          themeState = ThemeValueState(
              theme: ThemeData(primaryColor: Colors.cyan), color: Colors.cyan);
          break;
        case 'parçalı az bulutlu':
          themeState = ThemeValueState(
              theme: ThemeData(primaryColor: Colors.green),
              color: Colors.green);
          break;
        default:
          themeState = ThemeValueState(
              theme: ThemeData(primaryColor: Colors.amber),
              color: Colors.amber);
          break;
      }
      emit(themeState);
    });
  }
}
