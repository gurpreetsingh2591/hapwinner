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

class BookOfficeTimeSlotButtonPressed extends HomeEvent {
  final String parentId;
  final String date;
  final String time;

  const BookOfficeTimeSlotButtonPressed(
      {required this.parentId, required this.date, required this.time});

  @override
  List<Object> get props => [parentId, date, time];
}

