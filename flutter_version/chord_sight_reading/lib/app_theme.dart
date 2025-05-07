import 'styles.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  AppTheme._internal();

  bool _isDark = false;

  void toggleTheme() {
    _isDark = !_isDark;
  }

  void setTheme() {

  }

  get isDark => _isDark;

  get current => _isDark ? Styles.dark : Styles.parchment;
}
