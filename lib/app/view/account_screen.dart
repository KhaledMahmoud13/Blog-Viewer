import 'package:blog_viewer/app/controller/authentication_controller.dart';
import 'package:blog_viewer/app/controller/bottom_nav_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/app/view/components/account_item.dart';
import 'package:blog_viewer/app/view/components/default_button.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/routes_manager.dart';
import 'package:blog_viewer/core/resources/strings_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends GetView<UserController> {
  AccountScreen({super.key});

  final authenticationController = Get.find<AuthenticationController>();
  final bottomNavController = Get.find<BottomNavController>();

  List<Map<String, dynamic>> data = [
    {
      'title': AppStrings.profile,
      'icon': Icons.person,
    },
    {
      'title': AppStrings.password,
      'icon': Icons.key,
    },
    {
      'title': AppStrings.language,
      'icon': Icons.language,
    },
    {
      'title': AppStrings.inviteFriends,
      'icon': Icons.celebration_outlined,
    },
    {
      'title': AppStrings.help,
      'icon': Icons.help_rounded,
    },
    {
      'title': AppStrings.setting,
      'icon': Icons.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: AppSize.s50),
              Row(
                children: [
                  Obx(
                    () => Container(
                      width: AppSize.s70.w,
                      height: AppSize.s70.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.grey,
                        image: controller.imageUrl.value == 'null'
                            ? const DecorationImage(
                                image: AssetImage(ImageAssets.placeholder),
                                fit: BoxFit.contain,
                              )
                            : DecorationImage(
                                image: NetworkImage(
                                  controller.imageUrl.value,
                                ),
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s20),
                  Text(
                    controller.currentUser.fullName,
                    style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: FontSize.s22.sp,
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AccountItem(
                    icon: data[index]['icon'],
                    title: data[index]['title'],
                    onTap: () {
                      if (data[index]['title'] == AppStrings.profile) {
                        Get.toNamed(Routes.editProfileRoute);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: AppSize.s20),
              DefaultButton(
                child: Text(
                  AppStrings.logout,
                  style: GoogleFonts.titilliumWeb(
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () async {
                  await authenticationController.signOut(() async{
                    await Get.offNamed(Routes.loginRoute);
                    bottomNavController.signOut();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
