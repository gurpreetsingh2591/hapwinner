class EvenDates {
  String id;
  String title;
  String start;
  String end;
  String allDay;
  String url;
  String className;
  String type;
  String color;

  EvenDates({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.allDay,
    required this.url,
    required this.className,
    required this.type,
    required this.color,
  });

  factory EvenDates.fromJson(Map<String, dynamic> json) {
    return EvenDates(
      id: json['id'],
      title: json['title'],
      start: json['start'],
      end: json['end'],
      allDay: json['allDay'],
      url: json['url'],
      className: json['className'],
      type: json['type'],
      color: json['color'],
    );
  }
}

class EventDatesResponse {
  int status;
  String message;
  List<EvenDates> result;

  EventDatesResponse(
      {required this.status, required this.message, required this.result});

  factory EventDatesResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<EvenDates> evenDates = result.map((messageJson) {
      return EvenDates.fromJson(messageJson);
    }).toList();

    return EventDatesResponse(
      status: json['status'],
      message: json['message'],
      result: evenDates,
    );
  }
}
