import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef IsDarkMode = bool;

class ThemeNotifier extends StateNotifier<IsDarkMode> {
  ThemeNotifier(super.isDarkMode);

  void toggleTheme() {
    state = !state;
  }
}


final themeProvider = StateNotifierProvider<ThemeNotifier, IsDarkMode>((ref) {
  return ThemeNotifier(false);
});