import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'default_text_form.dart';

class DefaultTextFormWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  final bool enabled;

  const DefaultTextFormWidget({
    super.key,
    required this.text,
    required this.controller,
    required this.isPassword,
    required this.keyboardType,
    required this.validate,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.titilliumWeb(
            fontWeight: FontWeightManager.regular,
            fontSize: FontSize.s16.sp,
            color: ColorManager.black,
          ),
        ),
        const SizedBox(height: AppSize.s8),
        DefaultTextForm(
          controller: controller,
          isPassword: isPassword,
          keyboardType: keyboardType,
          validate: validate,
          enabled: enabled,
        ),
        const SizedBox(height: AppSize.s16),
      ],
    );
  }
}
