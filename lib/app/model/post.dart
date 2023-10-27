import 'package:blog_viewer/app/model/api_user.dart';
import 'package:blog_viewer/app/model/user_model.dart';

class Post {
  final dynamic userId;
  final dynamic id;
  final String title;
  final String body;
  ApiUser? apiUser;
  UserModel? userModel;

  Post({
    required this.userId,
    this.id,
    required this.title,
    required this.body,
    this.apiUser,
    this.userModel,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  factory Post.fromFirebaseJson(String id, Map<String, dynamic> json) => Post(
        id: id,
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'body': body,
      };
}
