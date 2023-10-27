import 'dart:io';

import 'package:blog_viewer/core/utils/constants.dart';
import 'package:blog_viewer/core/utils/extensions.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImageToFirebaseStorage(
      String imagePath, String email) async {
    try {
      final Reference storageReference = _storage
          .ref()
          .child('${Constants.profilePicturesPath}${email.toId()}');
      final UploadTask uploadTask = storageReference.putFile(File(imagePath));

      await uploadTask.whenComplete(() async {
        final imageUrl = await storageReference.getDownloadURL();
        return imageUrl;
      });
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      return null;
    }
    return null;
  }

  Future<String> getImageUrl(String imageName) async {
    if (imageName != 'null') {
      Reference reference =
          _storage.ref().child(Constants.profilePicturesPath).child(imageName);
      return await reference.getDownloadURL();
    } else {
      return 'null';
    }
  }
}
