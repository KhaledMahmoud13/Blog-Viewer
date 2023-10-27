import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var tabIndex = 0;

  void changeIndex(int index) {
    tabIndex = index;
    update();
  }

  void signOut() {
    tabIndex = 0;
    update();
  }
}
