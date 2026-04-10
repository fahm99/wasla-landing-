import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0C1445),
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF0E1647),
        onPrimaryContainer: Color(0xFF7980B6),
        secondary: Color(0xFF735C00),
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFFDD34D),
        onSecondaryContainer: Color(0xFF725B00),
        tertiary: Color(0xFF360F01),
        onTertiary: Colors.white,
        tertiaryContainer: Color(0xFF360F01),
        onTertiaryContainer: Color(0xFFB4745A),
        surface: Color(0xFFF7F9FC),
        onSurface: Color(0xFF191C1E),
        surfaceContainerHighest: Color(0xFFE0E3E6),
        onSurfaceVariant: Color(0xFF46464F),
        error: Color(0xFFBA1A1A),
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF93000A),
        outline: Color(0xFF767680),
        outlineVariant: Color(0xFFC7C5D0),
        inverseSurface: Color(0xFF2D3133),
        onInverseSurface: Color(0xFFEFF1F4),
        inversePrimary: Color(0xFFBCC3FD),
        surfaceTint: Color(0xFF535B8E),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.tajawal(
            fontWeight: FontWeight.w700, letterSpacing: -0.25),
        displayMedium: GoogleFonts.tajawal(fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.tajawal(fontWeight: FontWeight.w600),
        headlineLarge: GoogleFonts.cairo(fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        titleMedium:
            GoogleFonts.cairo(fontWeight: FontWeight.w600, letterSpacing: 0.15),
        titleSmall:
            GoogleFonts.cairo(fontWeight: FontWeight.w600, letterSpacing: 0.1),
        bodyLarge: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyMedium: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.w400, letterSpacing: 0.25),
        bodySmall: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.w400, letterSpacing: 0.4),
        labelLarge:
            GoogleFonts.cairo(fontWeight: FontWeight.w600, letterSpacing: 0.1),
        labelMedium:
            GoogleFonts.cairo(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        labelSmall:
            GoogleFonts.cairo(fontWeight: FontWeight.w500, letterSpacing: 0.5),
      ),
      fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,
    );
  }
}
