import 'package:blog_viewer/app/model/api_user.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/app/repository/user_repositroy.dart';
import 'package:blog_viewer/core/utils/constants.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository userRepository = UserRepository();

  late UserModel currentUser;
  final RxString imageUrl = RxString("");

  final RxString imagePath = RxString("");

  void setImagePath(String path) {
    imagePath.value = path;
  }

  final Rx<RequestStatus> requestStatus = RequestStatus.initial.obs;

  Future<void> getUser(String userId) async {
    requestStatus.value = RequestStatus.loading;
    try {
      final UserModel? user = await userRepository.getUser(userId);
      if (user != null) {
        currentUser = user;
        requestStatus.value = RequestStatus.loaded;
      } else {
        requestStatus.value = RequestStatus.error;
      }
    } catch (e) {
      print('Error getting user: $e');
      requestStatus.value = RequestStatus.error;
    }
  }

  Future<void> fetchImageUrl() async {
    try {
      imageUrl.value =
          await userRepository.getImageUrl(currentUser.profileImage);
    } catch (e) {
      print('Error fetching image URL: $e');
      imageUrl.value = 'null';
    }
  }

  Future<void> uploadImageToFirebaseStorage(String imagePath) async {
    await userRepository.uploadImageToFirebaseStorage(
        imagePath, currentUser.email);
  }

  Future<void> updateUserInformation(
    String userId,
    String firstname,
    String lastname,
    String profileImage,
  ) async {
    requestStatus.value = RequestStatus.loading;
    try {
      await uploadImageToFirebaseStorage(imagePath.value);
      await userRepository.updateUserInformation(
        userId,
        firstname,
        lastname,
        profileImage,
      );
      currentUser.updateUserInfo(firstname, lastname, profileImage);
      requestStatus.value = RequestStatus.loaded;
    } catch (e) {
      print('Error updating user: $e');
      requestStatus.value = RequestStatus.error;
    }
  }
}
