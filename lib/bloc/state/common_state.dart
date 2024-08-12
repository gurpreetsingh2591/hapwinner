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
class SuccessRedeemCouponState extends CommonState {
  final dynamic response;

  const SuccessRedeemCouponState(this.response);
}
class LoginWithOTPSuccessState extends CommonState {
  final dynamic response;

  const LoginWithOTPSuccessState(this.response);
}
class OTPSuccessState extends CommonState {
  final dynamic response;

  const OTPSuccessState(this.response);
}

class ResendOTPSuccessState extends CommonState {
  final dynamic response;

  const ResendOTPSuccessState(this.response);
}

class SocialLoginState extends CommonState {
  final dynamic response;

  const SocialLoginState(this.response);
}

