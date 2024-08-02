class LotteryData {
  final int status;
  final String message;
  final LotteryDetails data;

  LotteryData({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LotteryData.fromJson(Map<String, dynamic> json) {
    return LotteryData(
      status: json['status'],
      message: json['message'],
      data: LotteryDetails.fromJson(json['data']),
    );
  }
}

class LotteryDetails {
  final String ticketPrice;
  final Lottery lotteries;
  final TicketTotalNumber ticketTotalNumber;
  final LotterySpecification lotterySpecification;

  LotteryDetails({
    required this.ticketPrice,
    required this.lotteries,
    required this.ticketTotalNumber,
    required this.lotterySpecification,
  });

  factory LotteryDetails.fromJson(Map<String, dynamic> json) {
    return LotteryDetails(
      ticketPrice: json['ticket_price'],
      lotteries: Lottery.fromJson(json['lotteries']),
      ticketTotalNumber: TicketTotalNumber.fromJson(json['ticketstotalnumber']),
      lotterySpecification:
      LotterySpecification.fromJson(json['LotterySpecification']),
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

class TicketTotalNumber {
  final String totalNumbers;

  TicketTotalNumber({required this.totalNumbers});

  factory TicketTotalNumber.fromJson(Map<String, dynamic> json) {
    return TicketTotalNumber(
      totalNumbers: json['total_numbers'],
    );
  }
}

class LotterySpecification {
  final int id;
  final int lotteryId;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;

  LotterySpecification({
    required this.id,
    required this.lotteryId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LotterySpecification.fromJson(Map<String, dynamic> json) {
    return LotterySpecification(
      id: json['id'],
      lotteryId: json['lottery_id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
