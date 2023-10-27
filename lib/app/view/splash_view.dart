import 'package:blog_viewer/app/controller/authentication_controller.dart';
import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:blog_viewer/core/resources/assets_manager.dart';
import 'package:blog_viewer/core/resources/routes_manager.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:blog_viewer/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final authenticationController = Get.find<AuthenticationController>();
  final postsController = Get.find<PostsController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final authStatus = authenticationController.checkAuthenticationStatus();

    return Scaffold(
      body: FutureBuilder(
        future: authStatus == AuthenticationStatus.authenticated
            ? Future.wait([
                postsController.fetchPosts(),
                userController.getUser(
                    authenticationController.getCurrentUser()!.email!.toId()),
              ])
            : Future.value(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Center(
                child: Lottie.asset(ImageAssets.splash),
              ),
            );
          } else if (snapshot.hasError) {
            return SafeArea(
              child: Center(
                child: Lottie.asset(ImageAssets.splash),
              ),
            );
          } else {
            if (authStatus == AuthenticationStatus.authenticated) {
              Future.delayed(Duration.zero, () {
                Get.offNamed(Routes.homeRoute);
              });
            } else {
              Future.delayed(Duration.zero, () {
                Get.offNamed(Routes.loginRoute);
              });
            }
            return SafeArea(
              child: Center(
                child: Lottie.asset(ImageAssets.splash),
              ),
            );
          }
        },
      ),
    );
  }
}
