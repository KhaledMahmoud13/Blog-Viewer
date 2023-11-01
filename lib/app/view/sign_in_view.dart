import 'package:blog_viewer/app/controller/authentication_controller.dart';
import 'package:blog_viewer/app/view/components/default_button.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/routes_manager.dart';
import 'package:blog_viewer/core/resources/strings_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/default_text_form_widget.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final authController = Get.find<AuthenticationController>();

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
                    AppStrings.login,
                    style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s22.sp,
                      color: ColorManager.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                DefaultTextFormWidget(
                  text: AppStrings.email,
                  controller: _emailController,
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      AppStrings.forgotPasswordQuestion,
                      style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s16.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Obx(
                  () => DefaultButton(
                    child: authController.requestStatus.value ==
                            RequestStatus.loading
                        ? CircularProgressIndicator(color: ColorManager.white)
                        : Text(
                            AppStrings.login,
                            style: GoogleFonts.titilliumWeb(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s16.sp,
                              color: ColorManager.white,
                            ),
                          ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authController.signIn(
                            _emailController.text, _passwordController.text);
                        print(authController.requestStatus.value);
                        if (authController.requestStatus.value ==
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
                      AppStrings.registerQuestion,
                      style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s16.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed(Routes.registerRoute);
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
