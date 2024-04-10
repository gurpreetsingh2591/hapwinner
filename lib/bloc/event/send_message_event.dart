import 'package:equatable/equatable.dart';

abstract class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object> get props => [];
}

class SendToOfficeButtonPressed extends SendMessageEvent {
  final String studentId;
  final String subject;
  final String message;

  const SendToOfficeButtonPressed({required this.studentId, required this.subject, required this.message});

  @override
  List<Object> get props => [studentId,subject, message];
}

class GetOfficeSentMessages extends SendMessageEvent {
  final String studentId;
  const GetOfficeSentMessages({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

class SendToTeacherButtonPressed extends SendMessageEvent {
  final String studentId;
  final String subject;
  final String message;

  const SendToTeacherButtonPressed({required this.studentId, required this.subject, required this.message});

  @override
  List<Object> get props => [studentId,subject, message];
}

class GetTeacherSentMessages extends SendMessageEvent {
  final String studentId;
  const GetTeacherSentMessages({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

