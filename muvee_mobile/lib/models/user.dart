class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        username: data['username'],
        email: data['email'],
      );
}
