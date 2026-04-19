import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  // WhatsApp green palette
  static const primaryGreen  = Color(0xFF00A884);
  static const darkGreen     = Color(0xFF008069);
  static const lightGreen    = Color(0xFFDCF8C6); // sent bubble light
  static const sentBubbleDark  = Color(0xFF005C4B);
  static const recvBubbleLight = Color(0xFFFFFFFF);
  static const recvBubbleDark  = Color(0xFF1F2C34);
  static const bgLight       = Color(0xFFECE5DD);
  static const bgDark        = Color(0xFF0B141A);
  static const surfaceDark   = Color(0xFF1F2C34);
  static const appBarDark    = Color(0xFF1F2C34);
  static const appBarLight   = Color(0xFF008069);
  static const onlineColor   = Color(0xFF00A884);
  static const readColor     = Color(0xFF53BDEB);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary:   primaryGreen,
        secondary: darkGreen,
        surface:   Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor:    appBarLight,
        foregroundColor:    Colors.white,
        elevation:          0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:           appBarLight,
          statusBarIconBrightness:  Brightness.light,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary:   primaryGreen,
        secondary: darkGreen,
        surface:   surfaceDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor:    appBarDark,
        foregroundColor:    Colors.white,
        elevation:          0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:           appBarDark,
          statusBarIconBrightness:  Brightness.light,
        ),
      ),
      scaffoldBackgroundColor: bgDark,
      fontFamily: 'Roboto',
    );
  }
}