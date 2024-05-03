import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/login_event.dart';
import '../state/common_state.dart';

class LoginBloc extends Bloc<LoginEvent, CommonState> {
  LoginBloc() : super(InitialState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<GetUserProfileData>(_onGetUserProfileData);
    on<GetUserProfileDataUpdate>(_onGetUserProfileUpdateData);
    on<GetChangePasswordButtonPressed>(_onGetChangePasswordButtonPressed);
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


  /// get user profile data
  Future<void> _onGetUserProfileData(
      GetUserProfileData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getUserProfileData(event.parentId);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(GetProfileDataState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  /// get update user profile data
  Future<void> _onGetUserProfileUpdateData(
      GetUserProfileDataUpdate event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getUserUpdateProfileData(event.parentId,event.profileData);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(GetUpdateProfileDataState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }
  Future<void> _onGetChangePasswordButtonPressed(
      GetChangePasswordButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getData = await ApiService().getUserChangePasswordData(event.parentId,event.oldPassword,event.newPassword,event.confirmPassword);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print("change password response : $getData");
      }
      emit(GetChangePasswordState(getData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

// Other methods and event handlers...
}
