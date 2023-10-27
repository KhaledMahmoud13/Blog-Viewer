import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTextForm extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  final bool enabled;

  const DefaultTextForm({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.keyboardType,
    required this.validate,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validate,
      enabled: enabled,
      keyboardType: keyboardType,
      style: GoogleFonts.titilliumWeb(
        fontWeight: FontWeightManager.regular,
        fontSize: FontSize.s14.sp,
      ),
    );
  }
}
