import 'package:blog_viewer/app/datasource/remote/firebase_remote_data_source.dart';
import 'package:blog_viewer/app/datasource/remote/firebase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseRemoteDataSource _firebaseRemoteDataSource =
      FirebaseRemoteDataSource();
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  Future<User?> signUp(
      UserModel user, String password, String imagePath) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      if (imagePath != '') {
        await _firebaseStorageService.uploadImageToFirebaseStorage(imagePath, user.email);
      }
      var x = await _firebaseRemoteDataSource.postUser(user);
      print(x.body);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print('Signup Error: $e');
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print('SignIn Error: $e');
      return null;
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
