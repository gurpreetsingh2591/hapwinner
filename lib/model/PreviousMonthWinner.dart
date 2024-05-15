import 'package:hap_winner_project/model/LotteryDetail.dart';

import 'Ticket.dart';
import 'User.dart';
import 'UserDetails.dart';

class PreviousMonthWinner {
  final int id;
  final int userId;
  final int lotteryId;
  final int ticketId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Ticket ticket;
 // final UserDetails userDetails;
  final LotteryDetail lotteryDetail;
  final User user;

  PreviousMonthWinner({
    required this.id,
    required this.userId,
    required this.lotteryId,
    required this.ticketId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.ticket,
   // required this.userDetails,
    required this.lotteryDetail,
    required this.user,
  });

  factory PreviousMonthWinner.fromJson(Map<String, dynamic> json) {
    return PreviousMonthWinner(
      id: json['id'],
      userId: json['user_id'],
      lotteryId: json['lottery_id'],
      ticketId: json['ticket_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      ticket: Ticket.fromJson(json['ticket']),
      //userDetails: UserDetails.fromJson(json['userdetails']),
      lotteryDetail: LotteryDetail.fromJson(json['lottery']),
      user: User.fromJson(json['user']),
    );
  }
}
