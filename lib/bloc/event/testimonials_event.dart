import 'package:equatable/equatable.dart';

abstract class TestimonialsEvent extends Equatable {

  const TestimonialsEvent();

  @override
  List<Object> get props => [];
}
///Office Booking
class GetTestimonialsVideo extends TestimonialsEvent {
  final String token;

  const GetTestimonialsVideo({required this.token});

  @override
  List<Object> get props => [token];
}

class BookOfficeTimeSlotButtonPressed extends TestimonialsEvent {
  final String parentId;
  final String date;
  final String time;

  const BookOfficeTimeSlotButtonPressed(
      {required this.parentId, required this.date, required this.time});

  @override
  List<Object> get props => [parentId, date, time];
}

