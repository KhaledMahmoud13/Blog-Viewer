import 'dart:convert';

import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/core/utils/constants.dart';
import 'package:blog_viewer/core/utils/extensions.dart';
import 'package:http/http.dart' as http;

class FirebaseRemoteDataSource {
  final Map<String, UserModel> userCache = {};

  Future<http.Response> postUser(UserModel user) async {
    var url = Uri.parse(Constants.usersPath(user.email.toId()));
    return await http.put(url, body: jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser(String userId) async {
    var url = Uri.parse(Constants.usersPath(userId));
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      UserModel user;
      user = UserModel.fromJson(userId, json);
      return user;
    } else {
      return null;
    }
  }

  Future<http.Response> postPost(Post post) async {
    var url = Uri.parse(Constants.firebasePostsPath);
    var response = await http.post(url, body: jsonEncode(post.toJson()));
    return response;
  }

  Future<List<Post>> getPosts() async {
    var url = Uri.parse(Constants.firebasePostsPath);
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.body != null) {
          var body = jsonDecode(response.body) as Map<String, dynamic>;
          List<Post> posts = [];
          // body.forEach(
          //     (id, json) => posts.add(Post.fromFirebaseJson(id, json)));

          for (var entry in body.entries) {
            var id = entry.key;
            var json = entry.value;

            Post post = Post.fromFirebaseJson(id, json);

            UserModel? user = userCache[post.userId];

            if (user == null) {
              user = await getUser(post.userId);
              if (user != null) {
                userCache[post.userId] = user;
              }
            }

            post.userModel = user;

            posts.add(post);
          }

          return posts;
        }
      }
    } catch (e) {
      print(e);
      return [];
    }
    return [];
  }

  Future<void> updateUserInformation(String userId, String firstname,
      String lastname, String profileImage) async {
    var url = Uri.parse(Constants.usersPath(userId));
    try {
      await http.patch(
        url,
        body: jsonEncode({
          'firstname': firstname,
          'lastname': lastname,
          'profileImage': profileImage,
        }),
      );
    } catch (e) {
      print(e);
    }
  }
}
