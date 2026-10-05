import 'package:flutter/material.dart';

/// AppState holds every piece of data that must be shared ("global")
/// across multiple screens: the theme mode and the user's profile name.
///
/// It extends ChangeNotifier so that any widget listening to it
/// (via Provider/Consumer) automatically rebuilds when notifyListeners()
/// is called -- this is the core of the app's reactive state management.
class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  String _userName = 'Guest User';
  int _activitiesCompleted = 0;

  bool get isDarkMode => _isDarkMode;
  String get userName => _userName;
  int get activitiesCompleted => _activitiesCompleted;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Toggles the global theme. Any screen using Consumer<AppState> or
  /// context.watch<AppState>() re-renders the instant this runs.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void updateUserName(String newName) {
    if (newName.trim().isEmpty) return;
    _userName = newName.trim();
    notifyListeners();
  }

  void incrementActivitiesCompleted() {
    _activitiesCompleted++;
    notifyListeners();
  }
}
