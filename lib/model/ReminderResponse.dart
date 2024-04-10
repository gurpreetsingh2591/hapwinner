class ReminderResponse {
  final String id;
  final String days;

  ReminderResponse({required this.id, required this.days});

  // Factory method to create a ReminderResponse from a JSON map
  factory ReminderResponse.fromJson(Map<String, dynamic> json) {
    return ReminderResponse(
      id: json['id'] ?? '',
      days: json['days'] ?? '',
    );
  }
}

class AlreadyReminderResponse {
  int status;
  String message;
  List<ReminderResponse> result;

  AlreadyReminderResponse({required this.status, required this.message, required this.result});

  factory AlreadyReminderResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<ReminderResponse> messages = result.map((messageJson) {
      return ReminderResponse.fromJson(messageJson);
    }).toList();

    return AlreadyReminderResponse(
      status: json['status'],
      message: json['message'],
      result: messages,
    );
  }
}
