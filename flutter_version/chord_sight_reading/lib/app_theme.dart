import 'styles.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  AppTheme._internal();

  bool _isDark = false;
  dynamic _themePreference = Styles.parchment;

  void toggleTheme() {
    _isDark = !_isDark;
  }

  void setTheme(String theme){
    if(!Styles.themes.keys.contains(theme)){
      return;
    }
    _themePreference = Styles.themes[theme]!;
  }


  get isDark => _isDark;

  get current => _themePreference;
}
