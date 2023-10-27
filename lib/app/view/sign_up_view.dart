import 'dart:io';

import 'package:blog_viewer/app/controller/authentication_controller.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/app/view/components/default_button.dart';
import 'package:blog_viewer/app/view/components/default_text_form_widget.dart';
import 'package:blog_viewer/app/view/components/image_dialog.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/routes_manager.dart';
import 'package:blog_viewer/core/resources/strings_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:blog_viewer/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpView extends GetView<AuthenticationController> {
  SignUpView({super.key});

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.registration,
                    style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s22.sp,
                      color: ColorManager.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.dialog(ImageDialog(authentication: true));
                    },
                    child: Container(
                      width: AppSize.s100.w,
                      height: AppSize.s100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.white,
                        image: controller.imagePath.value == ''
                            ? const DecorationImage(
                                image: AssetImage(ImageAssets.placeholder),
                                fit: BoxFit.contain,
                              )
                            : DecorationImage(
                                image:
                                    FileImage(File(controller.imagePath.value)),
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
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
                  keyboardType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    } else if (!value.isValidEmail()) {
                      return AppStrings.emailErrorMsg;
                    }
                    return null;
                  },
                ),
                DefaultTextFormWidget(
                  text: AppStrings.password,
                  controller: _passwordController,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s35),
                Obx(
                  () => DefaultButton(
                    child: controller.requestStatus.value ==
                            RequestStatus.loading
                        ?  CircularProgressIndicator(color: ColorManager.white)
                        : Text(
                            AppStrings.register,
                            style: GoogleFonts.titilliumWeb(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s16.sp,
                              color: ColorManager.white,
                            ),
                          ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.signUp(
                          UserModel(
                            firstname: _firstnameController.text,
                            lastname: _lastnameController.text,
                            email: _emailController.text,
                            profileImage: controller.imagePath.value == ''
                                ? 'null'
                                : _emailController.text.toId(),
                          ),
                          _passwordController.text,
                        );
                        print(controller.requestStatus.value);
                        if (controller.requestStatus.value ==
                            RequestStatus.loaded) {
                          Get.offNamed(Routes.splashRoute);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text(
                      AppStrings.haveAccountQuestion,
                      style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s16.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed(Routes.loginRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
