class StudentSubject {
  String name;
  String id;

  StudentSubject({required this.name,required this.id});

  factory StudentSubject.fromJson(Map<String, dynamic> json) {
    return StudentSubject(
      name: json['name'],
      id: json['id'],
    );
  }
}

class StudentSubjectResponse {
  int status;
  String message;
  List<StudentSubject> result;

  StudentSubjectResponse({required this.status, required this.message, required this.result});

  factory StudentSubjectResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<StudentSubject> subjectList = result.map((messageJson) {
      return StudentSubject.fromJson(messageJson);
    }).toList();

    return StudentSubjectResponse(
      status: json['status'],
      message: json['message'],
      result: subjectList,
    );
  }
}