import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/tickets_event.dart';
import '../state/common_state.dart';

class MyTicketBloc extends Bloc<TicketsEvent, CommonState> {
  MyTicketBloc() : super(InitialState()) {
    on<GetMyTicketListData>(_onGetMyTicketListData);
    on<GetMyPastTicketListData>(_onGetMyPastTicketListData);
  }

  Future<void> _onGetMyTicketListData(
      GetMyTicketListData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getMyTicketList(event.token);
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
