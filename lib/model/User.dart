class User {
  final int id;
  final String name;
  final String email;
  final bool otpVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.otpVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      otpVerified: json['otpverified'] == "1",
    );
  }
}
