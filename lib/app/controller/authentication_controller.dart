import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/app/repository/authentication_repository.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  final Rx<RequestStatus> requestStatus = RequestStatus.initial.obs;
  final RxString imagePath = RxString("");

  void setImagePath(String path) {
    imagePath.value = path;
  }

  AuthenticationStatus checkAuthenticationStatus() {
    final user = _authenticationRepository.getCurrentUser();
    return user != null ? AuthenticationStatus.authenticated : AuthenticationStatus.notAuthenticated;
  }

  Future<AuthenticationStatus> signUp(UserModel userModel, String password) async {
    requestStatus.value = RequestStatus.loading;
    try {
      final user = await _authenticationRepository.signUp(userModel, password, imagePath.value);
      requestStatus.value = RequestStatus.loaded;
      return user != null ? AuthenticationStatus.authenticated : AuthenticationStatus.notAuthenticated;
    } catch (e) {
      print('Error during signup: $e');
      requestStatus.value = RequestStatus.error;
      return AuthenticationStatus.notAuthenticated;
    }
  }

  Future<AuthenticationStatus> signIn(String email, String password) async {
    requestStatus.value = RequestStatus.loading;
    try {
      final user = await _authenticationRepository.signIn(email, password);
      requestStatus.value = RequestStatus.loaded;
      return user != null ? AuthenticationStatus.authenticated : AuthenticationStatus.notAuthenticated;
    } catch (e) {
      print('Error during signin: $e');
      requestStatus.value = RequestStatus.error;
      return AuthenticationStatus.notAuthenticated;
    }
  }

  Future<void> signOut(Function() onFinish) async {
    try {
      await _authenticationRepository.signOut();
      onFinish();
    } catch (e) {
      print('Error during signout: $e');
    }
  }

  User? getCurrentUser() {
    return _authenticationRepository.getCurrentUser();
  }
}