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

class GetUserProfileData extends LoginEvent {
  final String parentId;

  const GetUserProfileData({required this.parentId});

  @override
  List<Object> get props => [parentId];
}

class GetUserProfileDataUpdate extends LoginEvent {
  final String parentId;
  final Map<String, String> profileData;

  const GetUserProfileDataUpdate(
      {required this.parentId, required this.profileData});

  @override
  List<Object> get props => [parentId, profileData];
}

class GetChangePasswordButtonPressed extends LoginEvent {
  final String parentId;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const GetChangePasswordButtonPressed(
      {required this.oldPassword,
      required this.parentId,
      required this.newPassword,
      required this.confirmPassword});

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];
}

class LogoutButtonPressed extends LoginEvent {}
