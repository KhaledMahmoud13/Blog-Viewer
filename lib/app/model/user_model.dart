import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/core/utils/extensions.dart';

class UserModel {
  String? id;
  String firstname;
  String lastname;
  final String email;
  String profileImage;
  final List<Post>? posts;

  UserModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.profileImage,
    this.posts,
  }) {
    id ??= email.toId();
  }

  String get fullName => '$firstname $lastname';

  void updateUserInfo(
    String firstname,
    String lastname,
    String profileImage,
  ) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.profileImage = profileImage;
  }

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
        id: id,
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        profileImage: json['profileImage'],
        posts: json['posts'] != null
            ? List<Post>.from(json['posts'].map((json) => Post.fromJson(json)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'profileImage': profileImage,
        'posts': posts,
      };
}
