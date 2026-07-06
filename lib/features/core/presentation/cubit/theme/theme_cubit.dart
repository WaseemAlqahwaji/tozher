import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial());

  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      emit(const ThemeDarkMode());
    } else {
      emit(const ThemeLightMode());
    }
  }

  void setLightMode() {
    _isDarkMode = false;
    emit(const ThemeLightMode());
  }

  void setDarkMode() {
    _isDarkMode = true;
    emit(const ThemeDarkMode());
  }
}
