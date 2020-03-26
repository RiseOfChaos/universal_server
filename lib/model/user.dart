class User {
  int id;

  String username;

  String email;

  String password;

  DateTime joined;

  bool emailVerified;

  static User fromMap(Map<String, dynamic> map) {
    return User()
      ..id = map['id']
      ..username = map['username']
      ..email = map['email']
      ..password = map['password']
      ..joined = map['joined']
      ..emailVerified = map['emailVerified'];
  }
}
