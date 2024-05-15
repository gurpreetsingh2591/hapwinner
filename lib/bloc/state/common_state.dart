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
class SocialLoginState extends CommonState {
  final dynamic response;

  const SocialLoginState(this.response);
}

