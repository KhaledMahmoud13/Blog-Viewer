import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/app/view/components/post_item.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostView extends StatelessWidget {
  PostView({super.key});

  final postsController = Get.find<PostsController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    userController.fetchImageUrl();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p5),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome, ${userController.currentUser.firstname}',
                      style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s18.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    Obx(
                      () => Container(
                        width: AppSize.s70.w,
                        height: AppSize.s70.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.grey,
                          image: userController.imageUrl.value == 'null'
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
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postsController.posts.length,
                itemBuilder: (context, index) => PostItem(
                  post: postsController.posts[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
