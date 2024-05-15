import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class FailureState extends HomeState {
  final String error;

  const FailureState(this.error);
}
class GetHomeState extends HomeState {
  final dynamic response;

  const GetHomeState(this.response);
}
class GetTestimonialsState extends HomeState {
  final dynamic response;

  const GetTestimonialsState(this.response);
}

class GetOfficeBookingSuccessState extends HomeState {
  final dynamic response;

  const GetOfficeBookingSuccessState(this.response);
}
class GetOfficeBookedSuccessState extends HomeState {
  final dynamic response;

  const GetOfficeBookedSuccessState(this.response);
}
class GetDeleteOfficeBookedSuccessState extends HomeState {
  final dynamic response;

  const GetDeleteOfficeBookedSuccessState(this.response);
}

class GetTeacherSlotState extends HomeState {
  final dynamic response;

  const GetTeacherSlotState(this.response);
}

class GetTeacherBookingSuccessState extends HomeState {
  final dynamic response;

  const GetTeacherBookingSuccessState(this.response);
}
class GetTeacherBookedSuccessState extends HomeState {
  final dynamic response;

  const GetTeacherBookedSuccessState(this.response);
}
class GetDeleteTeacherBookingState extends HomeState {
  final dynamic response;

  const GetDeleteTeacherBookingState(this.response);
}
