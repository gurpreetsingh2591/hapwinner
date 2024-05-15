class UserResponse {
  final int status;
  final String message;
  final UserData data;

  UserResponse({required this.status, required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final User user;
  final UserDetails userDetails;

  UserData({required this.user, required this.userDetails});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      userDetails: UserDetails.fromJson(json['userdetails']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String gender;
  final String phoneNumber;
  final String email;
  final int otp;
  final String otpVerified;
  final int role;
  final String createdAt;
  final String updatedAt;
  final String isPass;
  final String passwordResetToken;
  final String passwordResetCreatedAt;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.otp,
    required this.otpVerified,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.isPass,
    required this.passwordResetToken,
    required this.passwordResetCreatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      otp: json['otp'],
      otpVerified: json['otp_verified'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isPass: json['is_pass'],
      passwordResetToken: json['password_reset_token'],
      passwordResetCreatedAt: json['password_reset_created_at'],
    );
  }
}

class UserDetails {
  final int? id;
  final int? userId;
  final String? dateOfBirth;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? pincode;
  final String? language;
  final String? timezone;
  final String? currency;
  final String? image;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  UserDetails({
    required this.id,
    required this.userId,
    required this.dateOfBirth,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.language,
    required this.timezone,
    required this.currency,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      userId: json['user_id'],
      dateOfBirth: json['dateofbirth'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      language: json['language'],
      timezone: json['timezone'],
      currency: json['currency'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
