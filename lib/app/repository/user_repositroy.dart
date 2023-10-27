import 'package:blog_viewer/app/datasource/remote/api_remote_data_source.dart';
import 'package:blog_viewer/app/datasource/remote/firebase_remote_data_source.dart';
import 'package:blog_viewer/app/datasource/remote/firebase_storage_service.dart';
import 'package:blog_viewer/app/model/api_user.dart';
import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/core/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseRemoteDataSource _firebaseRemoteDataSource =
      FirebaseRemoteDataSource();
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();
  final ApiRemoteDataSource _apiRemoteDataSource = ApiRemoteDataSource();

  Future<UserModel?> getUser(String userId) async {
    return await _firebaseRemoteDataSource.getUser(userId);
  }

  Future<String> getImageUrl(String imageName) async {
    return await _firebaseStorageService.getImageUrl(imageName);
  }

  Future<String?> uploadImageToFirebaseStorage(
      String imagePath, String email) async {
    return await _firebaseStorageService.uploadImageToFirebaseStorage(imagePath, email);
  }

  Future<ApiUser?> getApiUser(int id) async {
    return await _apiRemoteDataSource.getUser(id);
  }

  Future<void> updateUserInformation(String userId, String firstname,
      String lastname, String profileImage) async {
    await _firebaseRemoteDataSource.updateUserInformation(
        userId, firstname, lastname, profileImage);
  }
}
