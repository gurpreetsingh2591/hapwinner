class BookedMeeting {
  String meetdate;
  String meettime;
  String meetstatus;
  String meet_id;

  BookedMeeting({required this.meetdate,required this.meettime,required this.meetstatus,required this.meet_id,});

  factory BookedMeeting.fromJson(Map<String, dynamic> json) {
    return BookedMeeting(
      meetdate: json['meetdate'],
      meettime: json['meettime'],
      meetstatus: json['meetstatus'],
      meet_id: json['meet_id'],
    );
  }
}

class BookedMeetingResponse {
  int status;
  String message;
  List<BookedMeeting> result;

  BookedMeetingResponse({required this.status, required this.message, required this.result});

  factory BookedMeetingResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<BookedMeeting> messages = result.map((messageJson) {
      return BookedMeeting.fromJson(messageJson);
    }).toList();

    return BookedMeetingResponse(
      status: json['status'],
      message: json['message'],
      result: messages,
    );
  }
}