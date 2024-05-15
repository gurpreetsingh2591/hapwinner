import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';

import '../event/home_event.dart';
import '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<GetHomeData>(onGetHomeData);
    on<GetTestimonialsVideo>(onGetTestimonialsVideo);
  }

  Future<void> onGetHomeData(
      GetHomeData event, Emitter<HomeState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getData = await ApiService()
          .getHomeScreenData(event.token);
      // Process the API response
      // Emit a success state

      if (kDebugMode) {
        print(getData);
      }
      emit(GetHomeState(getData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }
  Future<void> onGetTestimonialsVideo(
      GetTestimonialsVideo event, Emitter<HomeState> emit) async {
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
      emit(GetTestimonialsState(getSlots));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

}
