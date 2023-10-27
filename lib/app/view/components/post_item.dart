import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/font_manager.dart';
import 'package:blog_viewer/core/resources/routes_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem({super.key, required this.post});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.detailsRoute, arguments: post);
      },
      child: Card(
        color: ColorManager.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUserImage(),
                  const SizedBox(width: AppSize.s10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userModel != null ? post.userModel!.fullName : post.apiUser != null ? post.apiUser!.name : '',
                        style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s14.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      Text(
                        post.userModel != null ? post.userModel!.email : post.apiUser!.email,
                        style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s14.sp,
                          color: ColorManager.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s15),
              Text(
                post.title,
                style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeightManager.semiBold,
                  fontSize: FontSize.s20.sp,
                  color: ColorManager.black,
                ),
              ),
              const SizedBox(height: AppSize.s15),
              Text(
                post.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s16.sp,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     buildUserImage(),
          //     const SizedBox(width: AppSize.s14),
          //     Expanded(
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             post.title,
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //             style: GoogleFonts.titilliumWeb(
          //               fontWeight: FontWeightManager.bold,
          //               fontSize: FontSize.s22.sp,
          //               color: ColorManager.black,
          //             ),
          //           ),
          //           const SizedBox(height: AppSize.s16),
          //           Text(
          //             post.body,
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 3,
          //             style: GoogleFonts.titilliumWeb(
          //               fontWeight: FontWeightManager.regular,
          //               fontSize: FontSize.s16.sp,
          //               color: ColorManager.black,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget buildUserImage() {
    return FutureBuilder(
      future: getImageUrl(),
      builder: (context, snapshot) {
        final imageUrl = snapshot.data;
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Container(
            width: AppSize.s50.w,
            height: AppSize.s50.h,
            color: ColorManager.grey,
            child: (imageUrl == null || imageUrl == 'null')
                ? Image.asset(
                    ImageAssets.placeholder,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
        );
      },
    );
  }

  Future<String> getImageUrl() async {
    if (post.userId is String) {
      if(post.userModel!.profileImage != 'null') {
        final postsController = Get.find<PostsController>();
        return await postsController.getImageUrl(post.userModel!.profileImage);
      }
    }
    return 'null';
  }
}
