class ReminderList {
  String id;
  String days;
  String daystext;

  ReminderList({required this.id, required this.days, required this.daystext});

  factory ReminderList.fromJson(Map<String, dynamic> json) {
    return ReminderList(
      id: json['id'],
      days: json['days'],
      daystext: json['daystext'],
    );
  }
}

class ReminderListResponse {
  int status;
  String message;
  List<ReminderList> result;

  ReminderListResponse(
      {required this.status, required this.message, required this.result});

  factory ReminderListResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<ReminderList> messages = result.map((messageJson) {
      return ReminderList.fromJson(messageJson);
    }).toList();

    return ReminderListResponse(
      status: json['status'],
      message: json['message'],
      result: messages,
    );
  }
}
