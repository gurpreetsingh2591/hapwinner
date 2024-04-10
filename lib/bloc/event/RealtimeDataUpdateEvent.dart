import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/get_device_state.dart';
import 'get_device_event.dart';

class RealtimeDataUpdateEvent extends DeviceEvent {
  final Map<String, dynamic> updatedData;

  const RealtimeDataUpdateEvent(this.updatedData);

  @override
  List<Object> get props => [updatedData];
}


// Inside your GetDeviceBloc
void onRealtimeDataUpdateEvent(RealtimeDataUpdateEvent event, Emitter<GetDeviceState> emit) {
  // Handle the event and emit the appropriate state
  emit(RealtimeDataUpdateState(event.updatedData));
}


