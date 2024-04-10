class TeacherMessages {
  String currtime;
  String txtmessage;

  TeacherMessages({required this.currtime, required this.txtmessage});

  factory TeacherMessages.fromJson(Map<String, dynamic> json) {
    return TeacherMessages(
      currtime: json['currtime'],
      txtmessage: json['txtmessage'],
    );
  }
}

class TeacherMessagesResponse {
  int status;
  String message;
  List<TeacherMessages> result;

  TeacherMessagesResponse({required this.status, required this.message, required this.result});

  factory TeacherMessagesResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<TeacherMessages> messages = result.map((messageJson) {
      return TeacherMessages.fromJson(messageJson);
    }).toList();

    return TeacherMessagesResponse(
      status: json['status'],
      message: json['message'],
      result: messages,
    );
  }
}