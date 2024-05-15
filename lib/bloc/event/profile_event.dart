import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

///Get Ticket Event
class GetSaveDataData extends ProfileEvent {
  final String token;
  final String name;
  final String email;
  final String phone;
  final String dob;
  final String address;
  final String city;
  final String state;
  final String country;
  final String pinCode;

  const GetSaveDataData({
    required this.token,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  @override
  List<Object> get props =>
      [token, name, email, phone, dob, address, city, state, country, pinCode];
}

///Get Ticket Event
class GetMyTicketListData extends ProfileEvent {
  final String token;

  const GetMyTicketListData({required this.token});

  @override
  List<Object> get props => [token];
}
