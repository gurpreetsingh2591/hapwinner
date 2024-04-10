import 'package:equatable/equatable.dart';

abstract class MessageMenuEvent extends Equatable {
  const MessageMenuEvent();

  @override
  List<Object> get props => [];
}
///Get Message From School Event
class GetSchoolMessageData extends MessageMenuEvent {
  final String studentId;


  const GetSchoolMessageData({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

///Get Message From Teacher Event
class GetTeacherMessageData extends MessageMenuEvent {
  final String studentId;


  const GetTeacherMessageData({required this.studentId});

  @override
  List<Object> get props => [studentId];
}



