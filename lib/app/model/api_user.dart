class ApiUser {
  final int id;
  final String name;
  final String username;
  final String email;

  ApiUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
      );
}
