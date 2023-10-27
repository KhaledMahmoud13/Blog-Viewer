class Constants {
  static int limit = 20;

  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static String firebaseBaseUrl =
      'https://blog-viewer-82209-default-rtdb.firebaseio.com';

  // static String postsPath(int page) =>
  //     '$baseUrl/posts?_page=$page&_limit=$limit';

  static String postsPath = '$baseUrl/posts';

  static String userPath(int id) => '$baseUrl/users/$id';

  static String usersPath(String userId) =>
      '$firebaseBaseUrl/users/$userId.json';

  static String firebasePostsPath = '$firebaseBaseUrl/posts.json';

  static String profilePicturesPath = 'profile_pictures/';
}
