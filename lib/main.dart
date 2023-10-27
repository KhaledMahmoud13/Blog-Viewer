import 'package:blog_viewer/app/view/edit_profile_view.dart';
import 'package:blog_viewer/app/view/home_view.dart';
import 'package:blog_viewer/app/view/show_details_view.dart';
import 'package:blog_viewer/app/view/sign_in_view.dart';
import 'package:blog_viewer/app/view/sign_up_view.dart';
import 'package:blog_viewer/app/view/splash_view.dart';
import 'package:blog_viewer/core/resources/color_manager.dart';
import 'package:blog_viewer/core/resources/routes_manager.dart';
import 'package:blog_viewer/core/resources/values_manager.dart';
import 'package:blog_viewer/core/utils/bindings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        360,
        690,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: ColorManager.black,
              ),
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p8,
                  horizontal: AppPadding.p12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  borderSide: const BorderSide(width: AppSize.s1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  borderSide: const BorderSide(width: AppSize.s1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  borderSide: const BorderSide(width: AppSize.s1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  borderSide: const BorderSide(width: AppSize.s1),
                ),
                errorStyle: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeight.normal,
                ),
              )),
          initialBinding: AppBindings(),
          initialRoute: Routes.splashRoute,
          getPages: [
            GetPage(
              name: Routes.splashRoute,
              page: () => SplashView(),
            ),
            GetPage(
              name: Routes.loginRoute,
              page: () => SignInView(),
            ),
            GetPage(
              name: Routes.registerRoute,
              page: () => SignUpView(),
            ),
            GetPage(
              name: Routes.homeRoute,
              page: () => HomeView(),
            ),
            GetPage(
              name: Routes.detailsRoute,
              page: () => ShowDetailsView(),
            ),
            GetPage(
              name: Routes.editProfileRoute,
              page: () => EditProfileView(),
            ),
          ],
        );
      },
    );
  }
}
