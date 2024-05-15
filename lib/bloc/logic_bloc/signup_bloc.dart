import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/signup_event.dart';
import '../state/common_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, CommonState> {
  SignUpBloc() : super(InitialState()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);

  }

  Future<void> _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      // Process the API response
      dynamic response = await ApiService().getUserSignUp(event.userEmail.trim());

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



// Other methods and event handlers...
}
