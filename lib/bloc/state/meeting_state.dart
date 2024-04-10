import 'package:equatable/equatable.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();

  @override
  List<Object> get props => [];
}

class InitialState extends MeetingState {}

class LoadingState extends MeetingState {}

class FailureState extends MeetingState {
  final String error;

  const FailureState(this.error);
}
class GetOfficeSlotState extends MeetingState {
  final dynamic response;

  const GetOfficeSlotState(this.response);
}

class GetOfficeBookingSuccessState extends MeetingState {
  final dynamic response;

  const GetOfficeBookingSuccessState(this.response);
}
class GetOfficeBookedSuccessState extends MeetingState {
  final dynamic response;

  const GetOfficeBookedSuccessState(this.response);
}
class GetDeleteOfficeBookedSuccessState extends MeetingState {
  final dynamic response;

  const GetDeleteOfficeBookedSuccessState(this.response);
}

class GetTeacherSlotState extends MeetingState {
  final dynamic response;

  const GetTeacherSlotState(this.response);
}

class GetTeacherBookingSuccessState extends MeetingState {
  final dynamic response;

  const GetTeacherBookingSuccessState(this.response);
}
class GetTeacherBookedSuccessState extends MeetingState {
  final dynamic response;

  const GetTeacherBookedSuccessState(this.response);
}
class GetDeleteTeacherBookingState extends MeetingState {
  final dynamic response;

  const GetDeleteTeacherBookingState(this.response);
}
