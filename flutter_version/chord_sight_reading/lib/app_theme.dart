import 'styles.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  AppTheme._internal();

  dynamic _themePreference = Styles.parchment;


  void setTheme(String theme){
    if(!Styles.themes.keys.contains(theme)){
      return;
    }
    _themePreference = Styles.themes[theme]!;
  }


  get current => _themePreference;
}
