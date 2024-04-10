import 'package:equatable/equatable.dart';

abstract class StudentLessonEvent extends Equatable {
  const StudentLessonEvent();

  @override
  List<Object> get props => [];
}

class GetSubjectData extends StudentLessonEvent {
  final String studentId;
  final String classId;


  const GetSubjectData({required this.studentId,required this.classId});

  @override
  List<Object> get props => [studentId,classId];
}
class GetLessonRecordData extends StudentLessonEvent {
  final String studentId;
  final String subjectId;


  const GetLessonRecordData({required this.studentId,required this.subjectId,});

  @override
  List<Object> get props => [studentId,subjectId];
}

class GetReminderListData extends StudentLessonEvent {

  const GetReminderListData();

  @override
  List<Object> get props => [];
}

class SetRemindersData extends StudentLessonEvent {
  final String studentId;
  final String days;

  const SetRemindersData({required this.studentId,required this.days});

  @override
  List<Object> get props => [studentId,days];
}
class SetAlreadyRemindersData extends StudentLessonEvent {
  final String studentId;
  final String days;
  const SetAlreadyRemindersData({required this.studentId,required this.days});

  @override
  List<Object> get props => [studentId,days];
}

class GetEventsData extends StudentLessonEvent {
  const GetEventsData();
  @override
  List<Object> get props => [];
}

class GetStudentPhotosData extends StudentLessonEvent {
  final String studentId;
  final int index;
  const GetStudentPhotosData({required this.studentId,required this.index});
  @override
  List<Object> get props => [studentId,index];
}



