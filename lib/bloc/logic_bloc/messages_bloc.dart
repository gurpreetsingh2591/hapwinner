import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/get_messages_event.dart';
import '../state/common_state.dart';

class MessagesBloc extends Bloc<MessageMenuEvent, CommonState> {
  MessagesBloc() : super(InitialState()) {
    on<GetSchoolMessageData>(_onGetSchoolMessageData);
    on<GetTeacherMessageData>(_onGetTeacherMessageData);
  }

  Future<void> _onGetSchoolMessageData(
      GetSchoolMessageData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getSchoolMessages(event.studentId);
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

  Future<void> _onGetTeacherMessageData(
      GetTeacherMessageData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getTeacherMessages(event.studentId);
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

// Other methods and event handlers...
}
