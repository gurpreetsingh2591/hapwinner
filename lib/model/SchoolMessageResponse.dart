class SchoolMessages {
  String currtime;
  String vchsubject;
  String txtmessage;

  SchoolMessages({required this.currtime, required this.vchsubject, required this.txtmessage});

  factory SchoolMessages.fromJson(Map<String, dynamic> json) {
    return SchoolMessages(
      currtime: json['currtime'],
      vchsubject: json['vchsubject'],
      txtmessage: json['txtmessage'],
    );
  }
}

class SchoolMessagesResponse {
  int status;
  String message;
  List<SchoolMessages> result;

  SchoolMessagesResponse({required this.status, required this.message, required this.result});

  factory SchoolMessagesResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<SchoolMessages> messages = result.map((messageJson) {
      return SchoolMessages.fromJson(messageJson);
    }).toList();

    return SchoolMessagesResponse(
      status: json['status'],
      message: json['message'],
      result: messages,
    );
  }
}