import 'package:blog_viewer/app/model/post.dart';
import 'package:blog_viewer/app/model/user_model.dart';
import 'package:blog_viewer/app/repository/posts_repository.dart';
import 'package:blog_viewer/app/repository/user_repositroy.dart';
import 'package:blog_viewer/core/utils/constants.dart';
import 'package:blog_viewer/core/utils/enums.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  final PostsRepository _postsRepository = PostsRepository();
  final UserRepository _userRepository = UserRepository();

  final _posts = <Post>[].obs;
  final Rx<RequestStatus> requestStatus = RequestStatus.initial.obs;

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    requestStatus.value = RequestStatus.loading;
    try {
      final firebasePosts = await _postsRepository.getPostsFromFirebase();
      _posts.assignAll(firebasePosts.reversed);
      final apiPosts = await _postsRepository.getPosts();
      _posts.addAll(apiPosts);
      requestStatus.value = RequestStatus.loaded;
    } catch (e) {
      print('Error fetching posts: $e');
      requestStatus.value = RequestStatus.error;
    }
  }

  Future<void> postPost(Post post, UserModel user) async {
    requestStatus.value = RequestStatus.loading;
    try {
      await _postsRepository.postPost(post);
      post.userModel = user;
      _posts.insert(0, post);
      requestStatus.value = RequestStatus.loaded;
    } catch (e) {
      print('Error posting a post: $e');
      requestStatus.value = RequestStatus.error;
    }
  }

  Future<String> getImageUrl(String profileImage) async {
    try {
      return await _userRepository.getImageUrl(profileImage);
    } catch (e) {
      print('Error getting image URL: $e');
      return 'null';
    }
  }
}
