import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/login_event.dart';
import '../event/student_lesson_event.dart';
import '../state/common_state.dart';

class StudentLessonBloc extends Bloc<StudentLessonEvent, CommonState> {
  StudentLessonBloc() : super(InitialState()) {
    on<GetSubjectData>(_onGetSubjectData);
    on<GetLessonRecordData>(_onGetLessonRecordData);
    on<GetReminderListData>(_onGetReminderListData);
    on<SetRemindersData>(_onSetRemindersData);
    on<GetStudentPhotosData>(_onGetStudentPhotosData);
    on<SetAlreadyRemindersData>(_onSetAlreadyRemindersData);
  }

  Future<void> _onGetSubjectData(
      GetSubjectData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData =
          await ApiService().getSubjectListList(event.studentId, event.classId);
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

  Future<void> _onGetLessonRecordData(
      GetLessonRecordData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService()
          .getLessonRecordList(event.studentId, event.subjectId);
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

  Future<void> _onGetReminderListData(
      GetReminderListData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getReminderList();
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(ReminderListState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  ///Set Reminders
  Future<void> _onSetRemindersData(
      SetRemindersData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData =
          await ApiService().setReminders(event.studentId, event.days);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(SetReminderListState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  ///Set already Reminders
  Future<void> _onSetAlreadyRemindersData(
      SetAlreadyRemindersData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData =
          await ApiService().alreadySetReminders(event.studentId, event.days);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(AlreadySetReminderListState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  ///Get Events

  ///Get Photos
  Future<void> _onGetStudentPhotosData(
      GetStudentPhotosData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getStudentPhotosDates(event.studentId,event.index);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(GetStudentPhotosState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

// Other methods and event handlers...
}
