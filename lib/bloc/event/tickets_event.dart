import 'package:equatable/equatable.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object> get props => [];
}

///Get Ticket Event
class GetTicketListData extends TicketsEvent {
  final String token;

  const GetTicketListData({required this.token});

  @override
  List<Object> get props => [token];
}

///Get Ticket Event
class GetMyTicketListData extends TicketsEvent {
  final String token;

  const GetMyTicketListData({required this.token});

  @override
  List<Object> get props => [token];
}
///Get Ticket Event
class GetMyPastTicketListData extends TicketsEvent {
  final String token;

  const GetMyPastTicketListData({required this.token});

  @override
  List<Object> get props => [token];
}

///Get My win Ticket Event
class GetMyWinTicketListData extends TicketsEvent {
  final String token;

  const GetMyWinTicketListData({required this.token});

  @override
  List<Object> get props => [token];
}
///Get Redeem Coupon
class GetRedeemCouponData extends TicketsEvent {
  final String couponCode;
  final String price;
  final String token;

  const GetRedeemCouponData({required this.couponCode,required this.price,required this.token});

  @override
  List<Object> get props => [couponCode,price,token];
}

///Get Buy Tickets
class GetBuyTicketsData extends TicketsEvent {
  final String userId;
  final String lotteryId;
  final String ticketNumber;
  final String paymentStatus;
  final String countryId;
  final String amount;
  final String transactionType;
  final String transactionId;
  final String token;

  const GetBuyTicketsData(
      {required this.userId,
      required this.lotteryId,
      required this.ticketNumber,
      required this.paymentStatus,
      required this.countryId,
      required this.amount,
      required this.transactionType,
      required this.transactionId,
      required this.token});

  @override
  List<Object> get props => [
        userId,
        lotteryId,
        ticketNumber,
        paymentStatus,
        countryId,
        amount,
        transactionType,
        transactionId,
        token
      ];
}
