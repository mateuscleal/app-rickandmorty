import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      // Cor principal
      scaffoldBackgroundColor: AppColors.background,
      // Fundo da aplicação
      fontFamily: 'Blinker',
      // Fonte padrão
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white, // Texto do AppBar
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        // Cor secundária
        onPrimary: Colors.white,
        onSecondary: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.secondary),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.buttonColor, // Cor dos botões
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor, // Fundo do botão elevado
          foregroundColor: Colors.white, // Cor do texto do botão elevado
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Botões arredondados
          ),
        ),
      ),
    );
  }
}
