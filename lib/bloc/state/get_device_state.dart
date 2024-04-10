
// States
abstract class GetDeviceState {}

class InitialGetDataState extends GetDeviceState {}

class LoadingGetDataState extends GetDeviceState {}

class DocumentNotFoundState extends GetDeviceState {
  final String error;

  DocumentNotFoundState(this.error);
}

class ErrorGetDataState extends GetDeviceState {
  final String error;

  ErrorGetDataState(this.error);
}

class LoadedGetDataState extends GetDeviceState {
  final  Map<String, dynamic> data;

  LoadedGetDataState(this.data);
}


// Add a new state for real-time updates
class RealtimeDataUpdateState extends GetDeviceState {
  final Map<String, dynamic> data;

  RealtimeDataUpdateState(this.data);


}
