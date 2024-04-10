import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/signup_event.dart';
import '../state/common_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, CommonState> {
  SignUpBloc() : super(InitialState()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<GetUserData>(_onGetUserData);
    on<GetUserEmailVerificationData>(_onGetUserEmailVerificationData);
  }

  Future<void> _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      // Process the API response
      dynamic response = await ApiService().signup(event.userEmail.trim(),event.password,event.firstName.trim(), event.lastName.trim() );

      // Emit a success state
      if (kDebugMode) {
        print(response);
      }
      emit(SuccessState(response));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetUserData(
      GetUserData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getUserData();
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(UserDataSuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetUserEmailVerificationData(
      GetUserEmailVerificationData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserVerificationData = await ApiService().emailVerification();
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserVerificationData);
      }
      emit(UserEmailVerificationSuccessState(getUserVerificationData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

// Other methods and event handlers...
}
