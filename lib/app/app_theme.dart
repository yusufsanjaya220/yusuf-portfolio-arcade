import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArcadeColors {
  // Midnight Slate Terminal Base (Zero purple/violet undertones)
  static const Color background = Color(0xFF090D16);
  static const Color backgroundCard = Color(0xFF0F172A);
  static const Color backgroundCardElevated = Color(0xFF1E293B);

  // Retro Cyber Accents (Clean, Authentic, Tech-focused)
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color terminalGreen = Color(0xFF10B981);
  static const Color matrixGreen = Color(0xFF00E676);
  static const Color scoreYellow = Color(0xFFFACC15);
  static const Color cyberAmber = Color(0xFFF59E0B);
  static const Color dangerRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
  static const Color accentOrange = Color(0xFFFF7A00);

  // Replaced legacy neonPurple with crisp terminal emerald to purge purple
  static const Color neonPurple = Color(0xFF10B981);

  // Texts & Borders
  static const Color textMain = Color(0xFFF1F5F9);
  static const Color textDim = Color(0xFF94A3B8);
  static const Color borderPixel = Color(0xFF334155);
}

class AppTheme {
  static ThemeData get retroTheme {
    final baseTextTheme = GoogleFonts.spaceGroteskTextTheme();
    
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ArcadeColors.background,
      primaryColor: ArcadeColors.neonCyan,
      colorScheme: const ColorScheme.dark(
        primary: ArcadeColors.neonCyan,
        secondary: ArcadeColors.terminalGreen,
        surface: ArcadeColors.backgroundCard,
        error: ArcadeColors.dangerRed,
      ),
      textTheme: baseTextTheme.apply(
        bodyColor: ArcadeColors.textMain,
        displayColor: ArcadeColors.textMain,
      ),
      cardTheme: CardThemeData(
        color: ArcadeColors.backgroundCard,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ArcadeColors.borderPixel, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  // Retro Arcade Typography
  static TextStyle pixel({
    double fontSize = 12,
    Color color = ArcadeColors.textMain,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 1.0,
    double height = 1.4,
  }) {
    return GoogleFonts.pressStart2p(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle body({
    double fontSize = 14,
    Color color = ArcadeColors.textMain,
    FontWeight fontWeight = FontWeight.normal,
    double height = 1.6,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: height,
    );
  }

  // Pixel Box Decoration Helper
  static BoxDecoration pixelBox({
    Color background = ArcadeColors.backgroundCard,
    Color borderColor = ArcadeColors.neonCyan,
    double borderWidth = 2.0,
    double radius = 4.0,
    bool glow = false,
  }) {
    return BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: glow
          ? [
              BoxShadow(
                color: borderColor.withValues(alpha: 0.35),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ]
          : null,
    );
  }
}
