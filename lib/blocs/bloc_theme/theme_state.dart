// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;
  const ThemeState(this.theme, this.color);

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial({
    required ThemeData theme,
    required MaterialColor color,
  }) : super(theme, color);

  @override
  List<Object> get props => [theme, color];
}

class ThemeValueState extends ThemeState {
  const ThemeValueState({
    required ThemeData theme,
    required MaterialColor color,
  }) : super(theme, color);

  @override
  List<Object> get props => [theme, color];
}
