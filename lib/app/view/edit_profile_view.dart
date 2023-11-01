import 'dart:io';

import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/app/view/components/default_text_form_widget.dart';
import 'package:blog_viewer/app/view/components/image_dialog.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/strings_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:blog_viewer/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/default_button.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final userController = Get.find<UserController>();

  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _firstnameController =
        TextEditingController(text: userController.currentUser.firstname);
    _lastnameController =
        TextEditingController(text: userController.currentUser.lastname);
    _emailController =
        TextEditingController(text: userController.currentUser.email);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: AppSize.s50),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.dialog(ImageDialog(authentication: false));
                    },
                    child: Container(
                      width: AppSize.s80.w,
                      height: AppSize.s80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.white,
                        image: userController.imagePath.value != ''
                            ? DecorationImage(
                                image:
                                    FileImage(File(userController.imagePath.value)),
                                fit: BoxFit.contain,
                              )
                            : userController.currentUser.profileImage == 'null'
                                ? const DecorationImage(
                                    image: AssetImage(ImageAssets.placeholder),
                                    fit: BoxFit.contain,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                      userController.imageUrl.value,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                DefaultTextFormWidget(
                  text: AppStrings.firstname,
                  controller: _firstnameController,
                  isPassword: false,
                  keyboardType: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    }
                    return null;
                  },
                ),
                DefaultTextFormWidget(
                  text: AppStrings.lastname,
                  controller: _lastnameController,
                  isPassword: false,
                  keyboardType: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    }
                    return null;
                  },
                ),
                DefaultTextFormWidget(
                  text: AppStrings.email,
                  controller: _emailController,
                  isPassword: false,
                  enabled: false,
                  keyboardType: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s20),
                DefaultButton(
                  child: Obx(
                    () => userController.requestStatus.value ==
                            RequestStatus.loading
                        ? CircularProgressIndicator(color: ColorManager.white)
                        : Text(
                            AppStrings.update,
                            style: GoogleFonts.titilliumWeb(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s16.sp,
                              color: ColorManager.white,
                            ),
                          ),
                  ),
                  onPressed: () async {
                    await userController.updateUserInformation(
                      userController.currentUser.id!,
                      _firstnameController.text,
                      _lastnameController.text,
                      userController.imagePath.value == ''
                          ? userController.currentUser.profileImage!
                          : userController.currentUser.email.toId(),
                    );
                    await userController.uploadImageToFirebaseStorage(
                      userController.imagePath.value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
