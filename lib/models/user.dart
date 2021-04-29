class User {
  int userId;
  String name;
  String email;
  bool isAdmin;
  String password;

  User({
    this.userId,
    this.name,
    this.email,
    this.isAdmin,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        name: responseData['fullName'],
        email: responseData['email'],
        isAdmin: responseData['isAdmin'],
        password: responseData['password']);
  }
}
