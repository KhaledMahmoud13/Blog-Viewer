import 'package:blog_viewer/app/controller/authentication_controller.dart';
import 'package:blog_viewer/app/controller/bottom_nav_controller.dart';
import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/controller/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(BottomNavController());
    Get.put(PostsController());
    Get.put(UserController());
  }
}
