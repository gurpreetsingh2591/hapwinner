import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String fcmToken;

  const LoginButtonPressed(
      {required this.username, required this.password, required this.fcmToken});

  @override
  List<Object> get props => [username, password, fcmToken];
}
class LoginWithOTPButtonPressed extends LoginEvent {
  final String username;
  final String fcmToken;

  const LoginWithOTPButtonPressed(
      {required this.username, required this.fcmToken});

  @override
  List<Object> get props => [username, fcmToken];
}

class OTPResendButtonPressed extends LoginEvent {
  final String userId;

  const OTPResendButtonPressed(
      {required this.userId});

  @override
  List<Object> get props => [userId];
}

class LoginOTPVerifyButtonPressed extends LoginEvent {
  final String user;
  final String otp;
  final String usertype;

  const LoginOTPVerifyButtonPressed(
      {required this.user,required this.otp, required this.usertype});

  @override
  List<Object> get props => [user, otp,usertype];
}

class GetSocialLoginData extends LoginEvent {
  final String emailId;
  final String socialId;
  final String name;
  const GetSocialLoginData({required this.emailId,required this.socialId, required this.name});

  @override
  List<Object> get props => [emailId,socialId,name];
}


class GetUserProfileDataUpdate extends LoginEvent {
  final String parentId;
  final Map<String, String> profileData;

  const GetUserProfileDataUpdate(
      {required this.parentId, required this.profileData});

  @override
  List<Object> get props => [parentId, profileData];
}

class GetForgotPasswordButtonPressed extends LoginEvent {
  final String email;

  const GetForgotPasswordButtonPressed(
      {required this.email});

  @override
  List<Object> get props => [email];
}
class GetChangePasswordButtonPressed extends LoginEvent {
  final String password;
  final String confirmPassword;
  final String token;

  const GetChangePasswordButtonPressed(
      {required this.password,required this.confirmPassword,required this.token});

  @override
  List<Object> get props => [password,confirmPassword,token];
}

class LogoutButtonPressed extends LoginEvent {}
