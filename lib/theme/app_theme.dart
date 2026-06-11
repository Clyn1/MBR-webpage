import 'package:flutter/material.dart';

class MColors {
  MColors._();
  static const Color obsidian = Color(0xFF1A1A1A);
  static const Color shell    = Color(0xFFF5F0E8);
  static const Color sunset   = Color(0xFFC8651A);
  static const Color lakeGold = Color(0xFFE8A030);
  static const Color lakeTeal = Color(0xFF1D6A72);
  static const Color warmSand = Color(0xFFE8E0D4);
  static const Color dusk     = Color(0xFF8B3A10);
  static const Color grey100  = Color(0xFFF8F5F0);
  static const Color grey400  = Color(0xFFBDB5A8);
  static const Color grey600  = Color(0xFF7A7268);
  static const Color grey800  = Color(0xFF3D3830);
}

// Use these as plain doubles — never inside a const constructor
class MSpacing {
  MSpacing._();
  static const double xs   = 4;
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 24;
  static const double xxl  = 32;
  static const double xxxl = 48;
}

class MRadius {
  MRadius._();
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double pill = 100;
}

class MTextStyles {
  MTextStyles._();

  static const TextStyle hero = TextStyle(
    fontSize: 30, fontWeight: FontWeight.w800,
    color: MColors.shell, height: 1.15, letterSpacing: -0.5,
  );
  static const TextStyle h1 = TextStyle(
    fontSize: 24, fontWeight: FontWeight.w700, color: MColors.obsidian,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w600, color: MColors.obsidian,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w600, color: MColors.obsidian,
  );
  static const TextStyle label = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w600,
    color: MColors.grey600, letterSpacing: 1.4,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400,
    color: MColors.grey800, height: 1.65,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w400,
    color: MColors.grey600, height: 1.5,
  );
  static const TextStyle price = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w700, color: MColors.sunset,
  );
  static const TextStyle priceSmall = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w600, color: MColors.sunset,
  );
  static const TextStyle button = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.3,
  );
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w600,
  );
  static const TextStyle tag = TextStyle(
    fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.8,
  );
}

class MilimaniTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: MColors.obsidian, secondary: MColors.sunset,
      tertiary: MColors.lakeTeal, surface: MColors.shell,
      onPrimary: MColors.shell, onSecondary: MColors.shell,
      onSurface: MColors.obsidian,
    ),
    scaffoldBackgroundColor: MColors.shell,
    appBarTheme: const AppBarTheme(
      backgroundColor: MColors.obsidian, foregroundColor: MColors.shell,
      elevation: 0, centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600,
        color: MColors.shell, letterSpacing: 1.8,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: MColors.warmSand, thickness: 1, space: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MColors.grey100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MRadius.md),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MRadius.md),
        borderSide: const BorderSide(color: MColors.warmSand),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MRadius.md),
        borderSide: const BorderSide(color: MColors.lakeTeal, width: 1.5),
      ),
      labelStyle: MTextStyles.bodySmall,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}
