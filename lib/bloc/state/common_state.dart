import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable {
  const CommonState();

  @override
  List<Object> get props => [];
}

class InitialState extends CommonState {}

class LoadingState extends CommonState {}

class FailureState extends CommonState {
  final String error;

  const FailureState(this.error);
}
class SuccessState extends CommonState {
  final dynamic response;

  const SuccessState(this.response);
}

class UserDataSuccessState extends CommonState {
  final dynamic response;

  const UserDataSuccessState(this.response);
}
class TeacherSendSuccessState extends CommonState {
  final dynamic response;

  const TeacherSendSuccessState(this.response);
}
class TeacherSentListDataSuccessState extends CommonState {
  final dynamic response;

  const TeacherSentListDataSuccessState(this.response);
}
class UserEmailVerificationSuccessState extends CommonState {
  final dynamic response;

  const UserEmailVerificationSuccessState(this.response);
}
class ReminderListState extends CommonState {
  final dynamic response;

  const ReminderListState(this.response);
}
class SetReminderListState extends CommonState {
  final dynamic response;

  const SetReminderListState(this.response);
}
class AlreadySetReminderListState extends CommonState {
  final dynamic response;
  const AlreadySetReminderListState(this.response);
}
class GetEventsListState extends CommonState {
  final dynamic response;

  const GetEventsListState(this.response);
}
class GetProfileDataState extends CommonState {
  final dynamic response;

  const GetProfileDataState(this.response);
}
class GetUpdateProfileDataState extends CommonState {
  final dynamic response;

  const GetUpdateProfileDataState(this.response);
}

class GetStudentPhotosState extends CommonState {
  final dynamic response;

  const GetStudentPhotosState(this.response);
}
class GetChangePasswordState extends CommonState {
  final dynamic response;

  const GetChangePasswordState(this.response);
}