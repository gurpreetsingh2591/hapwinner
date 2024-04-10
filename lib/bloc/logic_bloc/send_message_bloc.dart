import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/login_event.dart';
import '../event/send_message_event.dart';
import '../state/common_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, CommonState> {
  SendMessageBloc() : super(InitialState()) {
    on<SendToOfficeButtonPressed>(_onSentButtonPressed);
    on<GetOfficeSentMessages>(_onGetOfficeSentMessages);
    on<SendToTeacherButtonPressed>(_onSentTeacherButtonPressed);
    on<GetTeacherSentMessages>(_onGetTeacherSentMessages);
  }

  Future<void> _onSentButtonPressed(
      SendToOfficeButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      dynamic response =
          await ApiService().postSendMessagesToOffice(event.studentId, event.subject,event.message);

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

  Future<void> _onGetOfficeSentMessages(
      GetOfficeSentMessages event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getSentMessagesToOfficeList(event.studentId);
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

  Future<void> _onSentTeacherButtonPressed(
      SendToTeacherButtonPressed event, Emitter<CommonState> emit) async {
    // Handle the LoginButtonPressed event
    emit(LoadingState());

    try {
      dynamic response =
          await ApiService().postSendMessagesToTeacher(event.studentId, event.subject,event.message);

      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print("api response--$response");
      }
      emit(TeacherSendSuccessState(response));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetTeacherSentMessages(
      GetTeacherSentMessages event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getSentMessagesToTeacherList(event.studentId);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(TeacherSentListDataSuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

// Other methods and event handlers...
}
