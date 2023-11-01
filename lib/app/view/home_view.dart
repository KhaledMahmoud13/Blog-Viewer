import 'package:blog_viewer/app/controller/bottom_nav_controller.dart';
import 'package:blog_viewer/app/controller/posts_controller.dart';
import 'package:blog_viewer/app/view/account_screen.dart';
import 'package:blog_viewer/app/view/add_post_view.dart';
import 'package:blog_viewer/app/view/components/post_item.dart';
import 'package:blog_viewer/app/view/post_view.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              PostView(),
              AddPostView(),
              AccountScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.changeIndex,
          currentIndex: controller.tabIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          selectedLabelStyle: GoogleFonts.titilliumWeb(),
          unselectedLabelStyle: GoogleFonts.titilliumWeb(),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Add'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
      );
    });
  }
}
