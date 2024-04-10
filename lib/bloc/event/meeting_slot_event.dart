import 'package:equatable/equatable.dart';

abstract class MeetingSlotEvent extends Equatable {
  const MeetingSlotEvent();

  @override
  List<Object> get props => [];
}
///Office Booking
class GetOfficeTimeSlotsByDate extends MeetingSlotEvent {
  final String studentId;
  final String date;

  const GetOfficeTimeSlotsByDate({required this.date, required this.studentId});

  @override
  List<Object> get props => [studentId];
}

class BookOfficeTimeSlotButtonPressed extends MeetingSlotEvent {
  final String parentId;
  final String date;
  final String time;

  const BookOfficeTimeSlotButtonPressed(
      {required this.parentId, required this.date, required this.time});

  @override
  List<Object> get props => [parentId, date, time];
}

class GetBookedOfficeSlotsList extends MeetingSlotEvent {
  final String studentId;
  final String parentId;

  const GetBookedOfficeSlotsList(
      {required this.studentId, required this.parentId});

  @override
  List<Object> get props => [studentId, parentId];
}


///Teacher booking
class GetTeacherTimeSlotsByDate extends MeetingSlotEvent {
  final String studentId;
  final String date;

  const GetTeacherTimeSlotsByDate(
      {required this.date, required this.studentId});

  @override
  List<Object> get props => [studentId];
}

class BookTeacherTimeSlotButtonPressed extends MeetingSlotEvent {
  final String studentId;
  final String date;
  final String time;

  const BookTeacherTimeSlotButtonPressed(
      {required this.studentId, required this.date, required this.time});

  @override
  List<Object> get props => [studentId, date, time];
}

class GetBookedTeacherSlotsList extends MeetingSlotEvent {
  final String studentId;

  const GetBookedTeacherSlotsList({
    required this.studentId,
  });

  @override
  List<Object> get props => [studentId];
}
class GetDeleteTeacherSlotsList extends MeetingSlotEvent {
  final String meetId;

  const GetDeleteTeacherSlotsList({
    required this.meetId,
  });

  @override
  List<Object> get props => [meetId];
}
class GetDeleteOfficeSlotsList extends MeetingSlotEvent {
  final String meetId;

  const GetDeleteOfficeSlotsList({
    required this.meetId,
  });

  @override
  List<Object> get props => [meetId];
}
