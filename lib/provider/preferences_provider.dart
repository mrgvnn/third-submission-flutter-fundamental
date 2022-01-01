import 'package:firstffasubmission/utility/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({this.preferencesHelper}) {
    _getDailyRestoPreferences();
  }

  bool _isDailyRestoActive = false;
  bool get isDailyRestoActive => _isDailyRestoActive;

  void _getDailyRestoPreferences() async {
    _isDailyRestoActive = await preferencesHelper.isDailyRestoActive;
    notifyListeners();
  }

  void enableDailyResto(bool value) {
    preferencesHelper.setDailyResto(value);
    _getDailyRestoPreferences();
  }
}
