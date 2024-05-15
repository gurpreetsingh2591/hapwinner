class LotteryDetail {
  final int id;
  final String heading;
  final String name;
  final String prizeDescription;
  final DateTime startDate;
  final DateTime endDate;
  final String countryId;
  final int masterPrizeId;
  final int maxTickets;
  final DateTime resultDate;
  final int noOfWinners;
  final String bannerImage;
  final List<String> contestImages;
  final double estimatedLotteryAmount;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  LotteryDetail({
    required this.id,
    required this.heading,
    required this.name,
    required this.prizeDescription,
    required this.startDate,
    required this.endDate,
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

  factory LotteryDetail.fromJson(Map<String, dynamic> json) {
    return LotteryDetail(
      id: json['id'],
      heading: json['lottery_heading'],
      name: json['lottery_name'],
      prizeDescription: json['lottery_prize_description'],
      startDate: DateTime.parse(json['lottery_start_date']),
      endDate: DateTime.parse(json['lottery_end_date']),
      countryId: json['country_id'],
      masterPrizeId: json['master_prize_id'],
      maxTickets: int.parse(json['max_tickets']),
      resultDate: DateTime.parse(json['result_date']),
      noOfWinners: json['no_of_winners'],
      bannerImage: json['banner_image'],
      contestImages: json['contest_images'].split(','),
      estimatedLotteryAmount: double.parse(json['estimated_lottery_amount']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
