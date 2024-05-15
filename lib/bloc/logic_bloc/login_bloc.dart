import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/login_event.dart';
import '../state/common_state.dart';

class LoginBloc extends Bloc<LoginEvent, CommonState> {
  LoginBloc() : super(InitialState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginWithOTPButtonPressed>(_onLoginWithOtpButtonPressed);
    on<LoginOTPVerifyButtonPressed>(_onOtpVerifyButtonPressed);
    on<GetSocialLoginData>(_onGetSocialLoginData);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      dynamic response =
          await ApiService().getUserLogin(event.username.trim(), event.password,event.fcmToken);

      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print("api response--$response");
      }
      emit(SuccessState(response));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }
  Future<void> _onLoginWithOtpButtonPressed(
      LoginWithOTPButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      dynamic response =
          await ApiService().getUserLoginWithOtp(event.username.trim());

      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print("api response--$response");
      }
      emit(SuccessState(response));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }
  Future<void> _onOtpVerifyButtonPressed(
      LoginOTPVerifyButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      dynamic response =
          await ApiService().getUserLoginOtpVerify(event.user,event.otp,event.usertype);

      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print("api response--$response");
      }
      emit(SuccessState(response));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }
  Future<void> _onOtpResendButtonPressed(
      LoginWithOTPButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      dynamic response =
          await ApiService().getUserLoginWithOtp(event.username.trim());

      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print("api response--$response");
      }
      emit(SuccessState(response));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }


  /// get user profile data
  Future<void> _onGetSocialLoginData(
      GetSocialLoginData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getSocialLoginData(event.emailId,event.socialId,event.name);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(SocialLoginState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }


// Other methods and event handlers...
}
