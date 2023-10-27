import 'dart:io';

import 'package:blog_viewer/app/controller/authentication_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/strings_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageDialog extends StatelessWidget {
  final bool authentication;
  ImageDialog({super.key, required this.authentication});

  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s12)),
            ),
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                Text(
                  AppStrings.selectImageFrom,
                  style: GoogleFonts.titilliumWeb(
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16.sp,
                    color: ColorManager.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage(ImageSource.gallery);
                      },
                      child: Card(
                        color: ColorManager.white2,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: Column(
                            children: [
                              Image.asset(
                                ImageAssets.gallery,
                                height: AppSize.s60.h,
                                width: AppSize.s60.w,
                              ),
                              Text(
                                AppStrings.gallery,
                                style: GoogleFonts.titilliumWeb(
                                  color: ColorManager.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImage(ImageSource.camera);
                      },
                      child: Card(
                        color: ColorManager.white2,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: Column(
                            children: [
                              Image.asset(
                                ImageAssets.camera,
                                height: AppSize.s60.h,
                                width: AppSize.s60.w,
                              ),
                              Text(
                                AppStrings.camera,
                                style: GoogleFonts.titilliumWeb(
                                  color: ColorManager.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectImage(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    if (authentication) {
      final controller = Get.find<AuthenticationController>();
      controller.setImagePath(pickedFile!.path);
    }else{
      final controller = Get.find<UserController>();
      controller.setImagePath(pickedFile!.path);
    }

    print(pickedFile);
    Get.back();
  }
}
