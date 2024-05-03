import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';

import '../event/testimonials_event.dart';
import '../state/meeting_state.dart';

class HomeBloc extends Bloc<TestimonialsEvent, MeetingState> {
  HomeBloc() : super(InitialState()) {
    on<GetTestimonialsVideo>(onGetTestimonialsVideo);
    on<BookOfficeTimeSlotButtonPressed>(onBookOfficeTimeSlotButtonPressed);
  }

  Future<void> onGetTestimonialsVideo(
      GetTestimonialsVideo event, Emitter<MeetingState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getSlots = await ApiService()
          .getTestimonialsVideos(event.token);
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

  Future<void> onBookOfficeTimeSlotButtonPressed(
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
}
