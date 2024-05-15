import 'dart:convert';

// Class to represent the response with ticket numbers
class TicketNumbersResponse {
  final int status;
  final String message;
  final List<String> ticketNumbers;

  TicketNumbersResponse({
    required this.status,
    required this.message,
    required this.ticketNumbers,
  });

  // Convert JSON to a TicketNumbersResponse object
  factory TicketNumbersResponse.fromJson(Map<String, dynamic> json) {
    // Extract the list of ticket numbers from the JSON
    var ticketNumbers = List<String>.from(json['data']['ticketNumbers']);

    return TicketNumbersResponse(
      status: json['status'],
      message: json['message'],
      ticketNumbers: ticketNumbers,
    );
  }

  // Convert a TicketNumbersResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'ticketNumbers': ticketNumbers,
      },
    };
  }
}
