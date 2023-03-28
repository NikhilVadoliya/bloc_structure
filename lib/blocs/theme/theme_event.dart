import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {}

class DarkThemeEvent extends ThemeEvent {
  DarkThemeEvent();

  @override
  List<Object?> get props => [];
}

class LightThemeEvent extends ThemeEvent {
  LightThemeEvent();

  @override
  List<Object?> get props => [];
}
