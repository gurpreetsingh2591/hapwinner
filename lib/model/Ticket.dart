class Ticket {
  final int id;
  final int userId;
  final int lotteryId;
  final String ticketNumbers;
  final int countryId;
  final String paymentStatus;
  final DateTime purchaseDate;
  final int transactionId;

  Ticket({
    required this.id,
    required this.userId,
    required this.lotteryId,
    required this.ticketNumbers,
    required this.countryId,
    required this.paymentStatus,
    required this.purchaseDate,
    required this.transactionId,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      userId: json['user_id'],
      lotteryId: json['lottery_id'],
      ticketNumbers: json['ticket_number'],
      countryId: json['country_id'],
      paymentStatus: json['payment_status'],
      purchaseDate: DateTime.parse(json['purchase_date']),
      transactionId: json['transaction_id'],
    );
  }
}
