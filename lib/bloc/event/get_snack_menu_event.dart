import 'package:equatable/equatable.dart';

abstract class SnackMenuEvent extends Equatable {
  const SnackMenuEvent();

  @override
  List<Object> get props => [];
}

class GetSnackData extends SnackMenuEvent {
  final String studentId;


  const GetSnackData({required this.studentId});

  @override
  List<Object> get props => [studentId];
}
class GetLunchData extends SnackMenuEvent {
  final String studentId;


  const GetLunchData({required this.studentId});

  @override
  List<Object> get props => [studentId];
}



