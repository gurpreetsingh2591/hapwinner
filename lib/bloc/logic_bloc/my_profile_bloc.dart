import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/profile_event.dart';
import '../event/tickets_event.dart';
import '../state/common_state.dart';

class MyProfileBloc extends Bloc<ProfileEvent, CommonState> {
  MyProfileBloc() : super(InitialState()) {
    on<GetSaveDataData>(_onGetSaveDataData);
  }

  Future<void> _onGetSaveDataData(
      GetSaveDataData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getSaveProfile(
          event.name,
          event.email,
          event.dob,
          event.phone,
          event.address,
          event.city,
          event.state,
          event.country,
          event.pinCode,
          event.token);
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

  Future<void> _onGetMyPastTicketListData(
      GetMyPastTicketListData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getMyPastTicketList(event.token);
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
