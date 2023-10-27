import 'dart:convert';

import 'package:blog_viewer/app/model/api_user.dart';
import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/core/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiRemoteDataSource {
  final Map<int, ApiUser> userCache = {};

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(Constants.postsPath));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Post> posts = [];
        // final List<Post> posts = data.map((e) => Post.fromJson(e)).toList();

        for (var json in data) {
          Post post = Post.fromJson(json);
          ApiUser? user = userCache[post.userId];

          if (user == null) {
            user = await getUser(post.userId);
            if (user != null) {
              userCache[post.userId] = user;
            }
          }

          post.apiUser = user;

          posts.add(post);
        }

        return posts;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ApiUser?> getUser(int id) async {
    try {
      final response = await http.get(Uri.parse(Constants.userPath(id)));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        ApiUser user = ApiUser.fromJson(json);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
