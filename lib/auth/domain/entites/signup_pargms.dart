class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  String? id;

  SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.id,
  });

  factory SignUpParams.fromJson(Map<String, dynamic> json) {
    return SignUpParams(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'id': id,
    };
  }
}