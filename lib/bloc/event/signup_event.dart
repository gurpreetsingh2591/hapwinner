import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String userEmail;
  final String password;

  const SignUpButtonPressed({required this.firstName, required this.lastName,  required this.userEmail, required this.password});

  @override
  List<Object> get props => [firstName,lastName,userEmail, password];
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
