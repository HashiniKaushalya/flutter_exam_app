class User {
  int userId;
  String name;
  String email;
  String type;

  User({
    this.userId,
    this.name,
    this.email,
    this.type,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        type: responseData['type']);
  }
}
