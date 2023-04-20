part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final String weatherDesc;

  const ChangeThemeEvent({required this.weatherDesc});
  @override
  List<Object> get props => [weatherDesc];
}
