import 'LotteryDetail.dart';
import 'PreviousMonthWinner.dart';

class LotteryData {
  final LotteryDetail lotteryDetail;
  final double lotteryPrice;
  final List<PreviousMonthWinner> previousMonthWinners;

  LotteryData({
    required this.lotteryDetail,
    required this.lotteryPrice,
    required this.previousMonthWinners,
  });

  factory LotteryData.fromJson(Map<String, dynamic> json) {
    return LotteryData(
      lotteryDetail: LotteryDetail.fromJson(json['lottry_detail']),
      lotteryPrice: json['lottry_price'].toDouble(),
      previousMonthWinners: List<PreviousMonthWinner>.from(
        json['privousmonthwinners'].map((winner) => PreviousMonthWinner.fromJson(winner)),
      ),
    );
  }
}
