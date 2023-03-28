abstract class ThemeState {
  final bool isDark;

  ThemeState(this.isDark);
}

class ChangeTheme extends ThemeState {
  ChangeTheme(super.isDark);
}
