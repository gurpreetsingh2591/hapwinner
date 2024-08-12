import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/api/ApiService.dart';
import '../event/tickets_event.dart';
import '../state/common_state.dart';

class BuyTicketBloc extends Bloc<TicketsEvent, CommonState> {
  BuyTicketBloc() : super(InitialState()) {
    on<GetTicketListData>(_onGetTicketListData);
    on<GetBuyTicketsData>(_onGetBuyTicketsData);
    on<GetMyWinTicketListData>(_onGetMyWinTicketListData);
    on<GetRedeemCouponData>(_onGetRedeemCouponData);
  }

  Future<void> _onGetTicketListData(
      GetTicketListData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getTicketList(event.token);
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

  Future<void> _onGetMyWinTicketListData(
      GetMyWinTicketListData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getMyWinTicketList(event.token);
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

  Future<void> _onGetRedeemCouponData(
      GetRedeemCouponData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getRedeemCoupon(event.couponCode,event.price,event.token);
      // Process the API response
      // Emit a success state
      if (kDebugMode) {
        print(getUserData);
      }
      emit(SuccessRedeemCouponState(getUserData));
    } catch (error) {
      // Emit a failure state
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _onGetBuyTicketsData(
      GetBuyTicketsData event, Emitter<CommonState> emit) async {
    // Handle the Get User Data event
    emit(LoadingState());

    try {
      dynamic getUserData = await ApiService().getBuyTicketsMessages(
          event.userId,
          event.lotteryId,
          event.ticketNumber,
          event.paymentStatus,
          event.countryId,
          event.amount,
          event.transactionType,
          event.transactionId,event.token);
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
