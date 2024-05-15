import 'dart:convert';

// Parse the JSON data

class UserContestTicket {
  final int id;
  final int userId;
  final int? ticketId;
  final int lotteryId;
  final int amount;
  final String transationId;
  final int? customerId;
  final String transactionType;
  final String createdAt;
  final String updatedAt;
  final List<Ticket> tickets;

  UserContestTicket({
    required this.id,
    required this.userId,
    required this.ticketId,
    required this.lotteryId,
    required this.amount,
    required this.transationId,
    required this.customerId,
    required this.transactionType,
    required this.createdAt,
    required this.updatedAt,
    required this.tickets,
  });

  factory UserContestTicket.fromJson(Map<String, dynamic> json) {
    List<Ticket> tickets = (json['tickets'] as List)
        .map((ticketJson) => Ticket.fromJson(ticketJson))
        .toList();

    return UserContestTicket(
      id: json['id'],
      userId: json['user_id'],
      ticketId: json['ticket_id'],
      lotteryId: json['lottery_id'],
      amount: json['amount'],
      transationId: json['transation_id'],
      customerId: json['customer_id'],
      transactionType: json['transaction_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      tickets: tickets,
    );
  }
}

class Ticket {
  final int id;
  final int userId;
  final int lotteryId;
  final String ticketNumber;
  final int countryId;
  final String paymentStatus;
  final String purchaseDate;
  final int transactionId;
  final String createdAt;
  final String updatedAt;
  final Lottery lottery;

  Ticket({
    required this.id,
    required this.userId,
    required this.lotteryId,
    required this.ticketNumber,
    required this.countryId,
    required this.paymentStatus,
    required this.purchaseDate,
    required this.transactionId,
    required this.createdAt,
    required this.updatedAt,
    required this.lottery,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      userId: json['user_id'],
      lotteryId: json['lottery_id'],
      ticketNumber: json['ticket_number'],
      countryId: json['country_id'],
      paymentStatus: json['payment_status'],
      purchaseDate: json['purchase_date'],
      transactionId: json['transaction_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lottery: Lottery.fromJson(json['lottery']),
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

class UserDetails {
  final int id;
  final int userId;
  final String dateOfBirth;
  final String address;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final String? language;
  final String? timezone;
  final String? currency;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;

  UserDetails({
    required this.id,
    required this.userId,
    required this.dateOfBirth,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.language,
    required this.timezone,
    required this.currency,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      userId: json['user_id'],
      dateOfBirth: json['dateofbirth'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      language: json['language'],
      timezone: json['timezone'],
      currency: json['currency'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
