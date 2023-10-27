import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountItem extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function() onTap;

  const AccountItem({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSize.s16),
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                icon,
                color: ColorManager.black,
              ),
              const SizedBox(width: AppSize.s12),
              Text(
                title,
                style: GoogleFonts.titilliumWeb(
                  color: ColorManager.black,
                  fontSize: FontSize.s18.sp,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.black,
                size: AppSize.s20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
