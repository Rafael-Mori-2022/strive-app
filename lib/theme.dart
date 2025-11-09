import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightModeColors {
  static const lightPrimary = Color(0xFF7E5A00);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFFFDEA8);
  static const lightOnPrimaryContainer = Color(0xFF281A00);

  static const lightSecondary = Color(0xFFC04000);
  static const lightOnSecondary = Color(0xFFFFFFFF);

  static const lightTertiary = Color(0xFF0061A4);
  static const lightOnTertiary = Color(0xFFFFFFFF);

  static const lightError = Color(0xFFBA1A1A);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFFFDAD6);
  static const lightOnErrorContainer = Color(0xFF410002);

  static const lightInversePrimary = Color(0xFFFACC15);
  static const lightShadow = Color(0xFF000000);

  static const lightBackground = Color(0xFFF4F4F4);
  static const lightOnBackground = Color(0xFF1A1A1A);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightOnSurface = Color(0xFF1A1A1A);
  static const lightSurfaceVariant = Color(0xFFE0E0E0);
  static const lightOnSurfaceVariant = Color(0xFF444446);
}

class DarkModeColors {
  static const darkPrimary = Color(0xFFFACC15);
  static const darkOnPrimary = Color(0xFF422E00);
  static const darkPrimaryContainer = Color(0xFF5F4300);
  static const darkOnPrimaryContainer = Color(0xFFFFDEA8);

  static const darkSecondary = Color(0xFFFF8A65);
  static const darkOnSecondary = Color(0xFF5F1D00);

  static const darkTertiary = Color(0xFF53A9FF);
  static const darkOnTertiary = Color(0xFF003062);

  static const darkError = Color(0xFFFFB4AB);
  static const darkOnError = Color(0xFF690005);
  static const darkErrorContainer = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFDAD6);

  static const darkInversePrimary = Color(0xFF7E5A00);
  static const darkShadow = Color(0xFF000000);

  static const darkBackground = Color(0xFF0D0D0D);
  static const darkOnBackground = Color(0xFFE0E0E0);
  static const darkSurface = Color(0xFF1C1C1E);
  static const darkOnSurface = Color(0xFFE0E0E0);
  static const darkSurfaceVariant = Color(0xFF2C2C2E);
  static const darkOnSurfaceVariant = Color(0xFF8E8E93);
}

class SpacingTokens {
  static const double x2 = 4;
  static const double x3 = 8;
  static const double x4 = 12;
  static const double x5 = 16;
  static const double x6 = 20;
  static const double x7 = 24;
  static const double x8 = 32;
  static const double x9 = 40;
}

class RadiusTokens {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 20;
  static const double xl = 28;
  static const double pill = 999;
}

class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 24.0;
  static const double headlineSmall = 22.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  static const double labelLarge = 16.0;
  static const double labelMedium = 14.0;
  static const double labelSmall = 12.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}

ThemeData get lightTheme {
  final colorScheme = ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    inversePrimary: LightModeColors.lightInversePrimary,
    shadow: LightModeColors.lightShadow,
    background: LightModeColors.lightBackground,
    onBackground: LightModeColors.lightOnBackground,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
    surfaceVariant: LightModeColors.lightSurfaceVariant,
    onSurfaceVariant: LightModeColors.lightOnSurfaceVariant,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.background,
      foregroundColor: colorScheme.onBackground,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.lg)),
      margin: const EdgeInsets.all(0),
    ),
    dialogTheme: const DialogThemeData(
      elevation: 0,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      dividerColor: colorScheme.surfaceVariant,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: FontSizes.displayLarge,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: FontSizes.displayMedium,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: FontSizes.displaySmall,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: FontSizes.headlineLarge,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: FontSizes.headlineMedium,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: FontSizes.headlineSmall,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: FontSizes.titleLarge,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: FontSizes.titleMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: FontSizes.titleSmall,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: FontSizes.labelLarge,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: FontSizes.labelMedium,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: FontSizes.labelSmall,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: FontSizes.bodyLarge,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: FontSizes.bodyMedium,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: FontSizes.bodySmall,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
    ),
  );
}

ThemeData get darkTheme {
  final colorScheme = ColorScheme.dark(
    primary: DarkModeColors.darkPrimary,
    onPrimary: DarkModeColors.darkOnPrimary,
    primaryContainer: DarkModeColors.darkPrimaryContainer,
    onPrimaryContainer: DarkModeColors.darkOnPrimaryContainer,
    secondary: DarkModeColors.darkSecondary,
    onSecondary: DarkModeColors.darkOnSecondary,
    tertiary: DarkModeColors.darkTertiary,
    onTertiary: DarkModeColors.darkOnTertiary,
    error: DarkModeColors.darkError,
    onError: DarkModeColors.darkOnError,
    errorContainer: DarkModeColors.darkErrorContainer,
    onErrorContainer: DarkModeColors.darkOnErrorContainer,
    inversePrimary: DarkModeColors.darkInversePrimary,
    shadow: DarkModeColors.darkShadow,
    background: DarkModeColors.darkBackground,
    onBackground: DarkModeColors.darkOnBackground,
    surface: DarkModeColors.darkSurface,
    onSurface: DarkModeColors.darkOnSurface,
    surfaceVariant: DarkModeColors.darkSurfaceVariant,
    onSurfaceVariant: DarkModeColors.darkOnSurfaceVariant,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.background,
      foregroundColor: colorScheme.onBackground,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.lg)),
      margin: const EdgeInsets.all(0),
    ),
    dialogTheme: const DialogThemeData(elevation: 0),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      dividerColor: colorScheme.surfaceVariant,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: FontSizes.displayLarge,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: FontSizes.displayMedium,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: FontSizes.displaySmall,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: FontSizes.headlineLarge,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: FontSizes.headlineMedium,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: FontSizes.headlineSmall,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: FontSizes.titleLarge,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: FontSizes.titleMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: FontSizes.titleSmall,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: FontSizes.labelLarge,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: FontSizes.labelMedium,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: FontSizes.labelSmall,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: FontSizes.bodyLarge,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: FontSizes.bodyMedium,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: FontSizes.bodySmall,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
    ),
  );
}
