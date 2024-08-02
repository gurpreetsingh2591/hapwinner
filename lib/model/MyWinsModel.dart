import 'dart:convert';

// Parse the JSON data

class MyWinTicket {
  final int id;
  final int userId;
  final int? ticketId;
  final int lotteryId;
  final String status;

  //final List<Ticket> tickets;
  final Lottery lottery;


  MyWinTicket({
    required this.id,
    required this.userId,
    required this.ticketId,
    required this.lotteryId,
    required this.status,

    required this.lottery,

    // required this.tickets,
  });

  factory MyWinTicket.fromJson(Map<String, dynamic> json) {


    return MyWinTicket(
      id: json['id'],
      userId: json['user_id'],
      ticketId: json['ticket_id'],
      lotteryId: json['lottery_id'],
      status: json['status'],
      lottery: Lottery.fromJson(json['lottery']),

      // tickets: tickets,
    );
  }
}


class Lottery {
  final int id;
  final String lotteryHeading;
  final String lotteryName;
  final String lotteryPrizeDescription;
  final String lotteryStartDate;
  final String lotteryEndDate;
  final String countryId;
  final int masterPrizeId;
  final String maxTickets;
  final String resultDate;
  final int noOfWinners;
  final String bannerImage;
  final String contestImages;
  final String estimatedLotteryAmount;
  final int status;
  final String createdAt;
  final String updatedAt;

  Lottery({
    required this.id,
    required this.lotteryHeading,
    required this.lotteryName,
    required this.lotteryPrizeDescription,
    required this.lotteryStartDate,
    required this.lotteryEndDate,
    required this.countryId,
    required this.masterPrizeId,
    required this.maxTickets,
    required this.resultDate,
    required this.noOfWinners,
    required this.bannerImage,
    required this.contestImages,
    required this.estimatedLotteryAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lottery.fromJson(Map<String, dynamic> json) {
    return Lottery(
      id: json['id'],
      lotteryHeading: json['lottery_heading'],
      lotteryName: json['lottery_name'],
      lotteryPrizeDescription: json['lottery_prize_description'],
      lotteryStartDate: json['lottery_start_date'],
      lotteryEndDate: json['lottery_end_date'],
      countryId: json['country_id'],
      masterPrizeId: json['master_prize_id'],
      maxTickets: json['max_tickets'],
      resultDate: json['result_date'],
      noOfWinners: json['no_of_winners'],
      bannerImage: json['banner_image'],
      contestImages: json['contest_images'],
      estimatedLotteryAmount: json['estimated_lottery_amount'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

