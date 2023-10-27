import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/app/view/components/default_button.dart';
import 'package:blog_viewer/app/view/components/default_text_form_widget.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/strings_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostView extends StatelessWidget {
  AddPostView({super.key});

  final _titleController = TextEditingController();

  final _bodyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final PostsController postsController = Get.find<PostsController>();

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.createPost,
                    style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s20.sp,
                      color: ColorManager.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                DefaultTextFormWidget(
                  text: AppStrings.title,
                  controller: _titleController,
                  isPassword: false,
                  keyboardType: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    }
                    return null;
                  },
                ),
                DefaultTextFormWidget(
                  text: AppStrings.body,
                  controller: _bodyController,
                  isPassword: false,
                  keyboardType: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorMsg;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s20),
                Obx(
                  () => DefaultButton(
                    child: postsController.requestStatus.value ==
                            RequestStatus.loading
                        ? CircularProgressIndicator(color: ColorManager.white)
                        : Text(
                            AppStrings.submit,
                            style: GoogleFonts.titilliumWeb(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s16.sp,
                              color: ColorManager.white,
                            ),
                          ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await postsController.postPost(
                          Post(
                            userId: userController.currentUser.id!,
                            title: _titleController.text,
                            body: _bodyController.text,
                          ),
                          userController.currentUser,
                        );
                        _titleController.clear();
                        _bodyController.clear();
                      }
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
