import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;
  const ThemeChanged(this.themeMode);
}

class ThemeInit extends ThemeEvent {
  const ThemeInit();
}

class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    on<ThemeInit>((event, emit) async {
      final savedMode = await _getSavedThemeMode();
      emit(ThemeState(savedMode));
    });

    on<ThemeChanged>((event, emit) async {
      await _saveThemeMode(event.themeMode);
      emit(ThemeState(event.themeMode));
    });
  }

  static Future<ThemeMode> _getSavedThemeMode() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/theme_mode.txt');
      if (await file.exists()) {
        final content = await file.readAsString();
        switch (content.trim()) {
          case 'light':
            return ThemeMode.light;
          case 'dark':
            return ThemeMode.dark;
          case 'system':
            return ThemeMode.system;
        }
      }
    } catch (_) {}
    return ThemeMode.system;
  }

  static Future<void> _saveThemeMode(ThemeMode mode) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/theme_mode.txt');
      String val = 'system';
      if (mode == ThemeMode.light) val = 'light';
      if (mode == ThemeMode.dark) val = 'dark';
      await file.writeAsString(val);
    } catch (_) {}
  }
}
