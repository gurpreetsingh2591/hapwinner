import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/get_snack_menu_event.dart';
import '../event/login_event.dart';
import '../state/common_state.dart';

class SnackMenuBloc extends Bloc<SnackMenuEvent, CommonState> {
  SnackMenuBloc() : super(InitialState()) {
    on<GetSnackData>(_onGetSnackData);
    on<GetLunchData>(_onGetLunchData);
  }

  Future<void> _onGetSnackData(
      GetSnackData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getStudentSnackMenu(event.studentId);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(SuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetLunchData(
      GetLunchData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getStudentLunchMenu(event.studentId);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(SuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

// Other methods and event handlers...
}
