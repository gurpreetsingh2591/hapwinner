import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String userEmail;

  const SignUpButtonPressed({  required this.userEmail});

  @override
  List<Object> get props => [userEmail];
}

class GetUserData extends SignUpEvent {
  const GetUserData();

  @override
  List<Object> get props => [];
}

class GetUserEmailVerificationData extends SignUpEvent {
  const GetUserEmailVerificationData();

  @override
  List<Object> get props => [];
}

class LogoutButtonPressed extends SignUpEvent {

}
