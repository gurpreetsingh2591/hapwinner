import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class FailureState extends HomeState {
  final String error;

  const FailureState(this.error);
}
class GetHomeState extends HomeState {
  final dynamic response;

  const GetHomeState(this.response);
}
class GetTestimonialsState extends HomeState {
  final dynamic response;

  const GetTestimonialsState(this.response);
}

class GetContestDetailState extends HomeState {
  final dynamic response;

  const GetContestDetailState(this.response);
}
class GetAccountDeleteSuccessState extends HomeState {
  final dynamic response;

  const GetAccountDeleteSuccessState(this.response);
}



