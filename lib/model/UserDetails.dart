class UserDetails {
  final int id;
  final int userId;
  final dynamic address;
  final dynamic city;
  final dynamic state;
  final dynamic country;
  final dynamic pincode;
  final dynamic image;

  UserDetails({
    required this.id,
    required this.userId,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
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
      image: json['image'],
    );
  }
}
