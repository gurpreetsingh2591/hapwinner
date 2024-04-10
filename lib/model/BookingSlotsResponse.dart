class BookingSlots {
  String slot;

  BookingSlots({required this.slot});

  factory BookingSlots.fromJson(Map<String, dynamic> json) {
    return BookingSlots(
      slot: json['slot'],
    );
  }
}

class BookingSlotsResponse {
  int status;
  String message;
  List<BookingSlots> result;

  BookingSlotsResponse({required this.status, required this.message, required this.result});

  factory BookingSlotsResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<BookingSlots> messages = result.map((messageJson) {
      return BookingSlots.fromJson(messageJson);
    }).toList();

    return BookingSlotsResponse(
      status: json['status'],
      message: json['message'],
      result: messages,
    );
  }
}