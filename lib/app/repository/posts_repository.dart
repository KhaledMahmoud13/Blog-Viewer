import 'package:blog_viewer/app/datasource/remote/firebase_remote_data_source.dart';
import 'package:blog_viewer/app/datasource/remote/api_remote_data_source.dart';
import 'package:blog_viewer/app/model/post.dart';

class PostsRepository {
  final ApiRemoteDataSource _dataSource = ApiRemoteDataSource();
  final FirebaseRemoteDataSource _firebaseRemoteDataSource =
      FirebaseRemoteDataSource();

  Future<List<Post>> getPosts() async {
    return await _dataSource.getPosts();
  }

  Future<void> postPost(Post post) async {
    await _firebaseRemoteDataSource.postPost(post);
  }

  Future<List<Post>> getPostsFromFirebase() async {
    return await _firebaseRemoteDataSource.getPosts();
  }
}
