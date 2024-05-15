class UserDetails {
  final int id;
  final int userId;
  final String address;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? image;

  UserDetails({
    required this.id,
    required this.userId,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      image: json['image'],
    );
  }
}
