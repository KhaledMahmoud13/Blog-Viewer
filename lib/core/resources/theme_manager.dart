import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppPadding.p8,
        horizontal: AppPadding.p12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide: const BorderSide(width: AppSize.s1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide: const BorderSide(width: AppSize.s1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide: const BorderSide(width: AppSize.s1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide: const BorderSide(width: AppSize.s1),
      ),
      errorStyle: GoogleFonts.titilliumWeb(
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
