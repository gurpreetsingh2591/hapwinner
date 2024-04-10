class LessonRecord {
  final String lessonPlanId;
  final String classId;
  final String statusEd;
  final String statusPg;
  final String statusPi;
  final String lessonName;
  final String lessonPlaned;
  final String? lessonPresented; // This field is nullable
  final String? primarySubject; // This field is nullable

  LessonRecord({
    required this.lessonPlanId,
    required this.classId,
    required this.statusEd,
    required this.statusPg,
    required this.statusPi,
    required this.lessonName,
    required this.lessonPlaned,
    this.lessonPresented, // Mark this field as nullable
    this.primarySubject, // Mark this field as nullable
  });

  factory LessonRecord.fromJson(Map<String, dynamic> json) {
    return LessonRecord(
      lessonPlanId: json['lessonplanid'] ?? "",
      classId: json['classid'] ?? "",
      statusEd: json['status_ed'] ?? 0,
      statusPg: json['status_pg'] ?? 0,
      statusPi: json['status_pi'] ?? 0,
      lessonName: json['lessoname'] ?? "",
      lessonPlaned: json['lesson_planed'] ?? 0,
      lessonPresented: json['lesson_presented'], // This is nullable, so don't use the null-aware operator
      primarySubject: json['primary_subject'], // This is nullable, so don't use the null-aware operator
    );
  }
}

class DraftRecord {
  final String description;// This field is nullable

  DraftRecord({
    required this.description,

  });

  factory DraftRecord.fromJson(Map<String, dynamic> json) {
    return DraftRecord(
      description: json['description'] ?? "",

    );
  }
}
class LessonRecordResponse {
  int status;
  String message;
  List<LessonRecord> result;
  List<DraftRecord> draft;

  LessonRecordResponse(
      {required this.status, required this.message, required this.result, required this.draft});

  factory LessonRecordResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<LessonRecord> lessonRecord = result.map((messageJson) {
      return LessonRecord.fromJson(messageJson);
    }).toList();

    var draftJson = json['draft'] as List;
    List<DraftRecord> draft = draftJson.map((messageJson) {
      return DraftRecord.fromJson(messageJson);
    }).toList();

    return LessonRecordResponse(
      status: json['status'],
      message: json['message'],
      result: lessonRecord,
      draft: draft,
    );
  }
}

/*
class LessonRecord {
  String lessonplanid;
  String classid;
  String lessonstatus;
  String lessoname;
  String status_ed;
  String status_pg;
  String status_pi;
  String lesson_planed;
  String? lesson_presented;



  LessonRecord({required this.lessonplanid,
    required this.classid,
    required this.lessonstatus,
    required this.lessoname,
    required this.status_ed,
    required this.status_pg,
    required this.status_pi,
    required this.lesson_planed,
    required this.lesson_presented,
  });

  factory LessonRecord.fromJson(Map<String, dynamic> json) {
    return LessonRecord(
      lessonplanid: json['lessonplanid'],
      classid: json['classid'],
      lessonstatus: json['lessonstatus'],
      lessoname: json['lessoname'],
      status_ed: json['status_ed'],
      status_pg: json['status_pg'],
      status_pi: json['status_pi'],
      lesson_planed: json['lesson_planed'],
      lesson_presented: json['lesson_presented']??"0",
    );
  }
}

class LessonRecordResponse {
  int status;
  String message;
  List<LessonRecord> result;

  LessonRecordResponse(
      {required this.status, required this.message, required this.result});

  factory LessonRecordResponse.fromJson(Map<String, dynamic> json) {
    var result = json['result'] as List;
    List<LessonRecord> lessonRecord = result.map((messageJson) {
      return LessonRecord.fromJson(messageJson);
    }).toList();

    return LessonRecordResponse(
      status: json['status'],
      message: json['message'],
      result: lessonRecord,
    );
  }
}*/
