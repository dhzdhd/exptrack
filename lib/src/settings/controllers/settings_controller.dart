import 'package:exptrack/src/settings/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  SettingsModel build() => const SettingsModel(theme: ThemeMode.system);

  Future<void> updateThemeMode(ThemeMode? theme) async {
    state = state.copyWith(theme: theme!);
  }
}
