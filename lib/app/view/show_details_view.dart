import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/app/model/api_user.dart';
import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDetailsView extends StatelessWidget {
  ShowDetailsView({super.key});

  final UserController userController = Get.find<UserController>();
  final PostsController postsController = Get.find<PostsController>();
  final Post args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Row(
                children: [
                  buildUserImage(),
                  const SizedBox(width: AppSize.s25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args.userModel != null
                            ? args.userModel!.fullName
                            : args.apiUser!.name,
                        style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s16.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      Text(
                        args.userModel != null
                            ? args.userModel!.email
                            : args.apiUser!.email,
                        style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s12.sp,
                          color: ColorManager.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                args.title,
                style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeightManager.semiBold,
                  fontSize: FontSize.s24.sp,
                  color: ColorManager.black,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              Text(
                args.body,
                style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSize.s18.sp,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserImage() {
    return FutureBuilder(
      future: getImageUrl(),
      builder: (context, snapshot) {
        final imageUrl = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: AppSize.s80.w,
            height: AppSize.s100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.white,
            ),
            child: Center(
              child: CircularProgressIndicator(color: ColorManager.black),
            ),
          );
        } else {
          return Container(
            width: AppSize.s80.w,
            height: AppSize.s100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.white,
              image: (imageUrl == null || imageUrl == 'null')
                  ? const DecorationImage(
                      image: AssetImage(
                        ImageAssets.placeholder,
                      ),
                      fit: BoxFit.contain,
                    )
                  : DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ),
                      fit: BoxFit.contain,
                    ),
            ),
          );
        }
      },
    );
  }

  Future<String> getImageUrl() async {
    if (args.userId is String) {
      return await postsController.getImageUrl(args.userModel!.profileImage);
    }
    return 'null';
  }
}
