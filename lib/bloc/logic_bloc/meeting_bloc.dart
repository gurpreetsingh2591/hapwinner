import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';


import '../../data/api/ApiService.dart';

import '../event/meeting_slot_event.dart';
import '../state/meeting_state.dart';

class MeetingBloc extends Bloc<MeetingSlotEvent, MeetingState> {
  MeetingBloc() : super(InitialState()) {
    on<GetOfficeTimeSlotsByDate>(_onGetOfficeTimeSlotsByDate);
    on<BookOfficeTimeSlotButtonPressed>(_onBookOfficeTimeSlotButtonPressed);
    on<GetBookedOfficeSlotsList>(_onGetBookedOfficeSlotsList);

    on<GetTeacherTimeSlotsByDate>(_onGetTeacherTimeSlotsByDate);
    on<BookTeacherTimeSlotButtonPressed>(_onBookTeacherTimeSlotButtonPressed);
    on<GetBookedTeacherSlotsList>(_onGetBookedTeacherSlotsList);
    on<GetDeleteTeacherSlotsList>(_onGetDeleteBookedTeacherSlotsList);
    on<GetDeleteOfficeSlotsList>(_onGetDeleteOfficeSlotsList);
  }

  Future<void> _onGetOfficeTimeSlotsByDate(
      GetOfficeTimeSlotsByDate event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getSlots = await ApiService()
          .getOfficeTimeSlotListWithDate(event.studentId, event.date);
      // Process the API response
      // Emit a success state

      if (kDebugMode) {
        print(getSlots);
      }
      emit(GetOfficeSlotState(getSlots));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onBookOfficeTimeSlotButtonPressed(
      BookOfficeTimeSlotButtonPressed event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService()
          .getOfficeBookTimeSlot(event.parentId, event.date, event.time);
      // Process the API response
      // Emit a success state

      emit(GetOfficeBookingSuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetBookedOfficeSlotsList(
      GetBookedOfficeSlotsList event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic bookedSlot = await ApiService()
          .getOfficeBookedTimeSlotsList(event.studentId, event.parentId);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(bookedSlot);
      }
      emit(GetOfficeBookedSuccessState(bookedSlot));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetTeacherTimeSlotsByDate(
      GetTeacherTimeSlotsByDate event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService()
          .getTeacherTimeSlotListWithDate(event.studentId, event.date);
      // Process the API response
      // Emit a success state

      emit(GetTeacherSlotState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onBookTeacherTimeSlotButtonPressed(
      BookTeacherTimeSlotButtonPressed event,
      Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService()
          .getTeacherBookTimeSlot(event.studentId, event.date, event.time);

      emit(GetTeacherBookingSuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetBookedTeacherSlotsList(
      GetBookedTeacherSlotsList event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData =
          await ApiService().getTeacherBookedSlotList(event.studentId);
      // Process the API response
      // Emit a success state

      emit(GetTeacherBookedSuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }
  Future<void> _onGetDeleteBookedTeacherSlotsList(
      GetDeleteTeacherSlotsList event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData =
          await ApiService().getTeacherDeleteBookedSlot(event.meetId);
      // Process the API response
      // Emit a success state

      emit(GetDeleteTeacherBookingState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetDeleteOfficeSlotsList(
      GetDeleteOfficeSlotsList event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData =
          await ApiService().getOfficeDeleteBookedSlot(event.meetId);
      // Process the API response
      // Emit a success state

      emit(GetDeleteOfficeBookedSuccessState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

// Other methods and event handlers...
}
