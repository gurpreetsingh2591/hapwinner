import 'package:equatable/equatable.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class GetAllDevicesData extends DeviceEvent {
  final String documentId;


  const GetAllDevicesData({required this.documentId});

  @override
  List<Object> get props => [documentId];
}


class DeleteAllAlerts extends DeviceEvent {
  final String documentId;
  final int deviceId;


  const DeleteAllAlerts({required this.documentId,required this.deviceId});

  @override
  List<Object> get props => [documentId,deviceId];
}

class DeleteSingleAlert extends DeviceEvent {
  final String documentId;
  final int deviceId;
  final int alertId;


  const DeleteSingleAlert({required this.documentId,required this.deviceId,required this.alertId});

  @override
  List<Object> get props => [documentId,deviceId,alertId];
}
