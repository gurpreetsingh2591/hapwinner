class DeviceResponse {
  List<Device> devices;

  DeviceResponse({
    required this.devices,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> devicesJson = json['devices'];
    List<Device> devices =
    devicesJson.map((deviceJson) => Device.fromJson(deviceJson)).toList();

    return DeviceResponse(devices: devices);
  }
}

class Device {
  List<Alert> alerts;
  String deviceStatus;
  String deviceName;
  int deviceId;
  String lastUpdate;


  Device({
    required this.alerts,
    required this.deviceStatus,
    required this.deviceName,
    required this.deviceId,
    required this.lastUpdate,

  });

  factory Device.fromJson(Map<String, dynamic> json) {
    List<dynamic> alertsJson = json['alerts'];
    List<Alert> alerts =
    alertsJson.map((alertJson) => Alert.fromJson(alertJson)).toList();

    return Device(
      alerts: alerts,
      deviceStatus: json['device_status'],
      deviceName: json['device_name'],
      deviceId: json['device_id'],
      lastUpdate: json['last_update'],
    );
  }
}

class Alert {
  String date;
  String image;
  String name;
  int id;
  String time;

  Alert({
    required this.date,
    required this.image,
    required this.name,
    required this.id,
    required this.time,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      date: json['date'],
      image: json['image'],
      name: json['name'],
      id: json['id'],
      time: json['time'],
    );
  }
}
