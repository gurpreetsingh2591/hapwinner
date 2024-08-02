import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

///Office Booking
class GetHomeData extends HomeEvent {
  final String token;

  const GetHomeData({required this.token});

  @override
  List<Object> get props => [token];
}

///get testimonials
class GetTestimonialsVideo extends HomeEvent {
  final String token;

  const GetTestimonialsVideo({required this.token});

  @override
  List<Object> get props => [token];
}

class GetContestDetailPressed extends HomeEvent {
  final String token;

  const GetContestDetailPressed({required this.token});

  @override
  List<Object> get props => [token];
}
class GetPrivacyPressed extends HomeEvent {
  final String token;

  const GetPrivacyPressed({required this.token});

  @override
  List<Object> get props => [token];
}
class GetContactUsPressed extends HomeEvent {
  final String name;
  final String email;
  final String subject;
  final String message;
  final String token;

  const GetContactUsPressed({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.token
  });

  @override
  List<Object> get props => [name,email,subject,message,token];
}

class GetDeleteAccountData extends HomeEvent {
  final String id;

  const GetDeleteAccountData({required this.id});

  @override
  List<Object> get props => [id];
}

