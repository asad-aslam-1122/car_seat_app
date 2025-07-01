import 'package:car_seat/feature/global/constant/enums.dart';

class DeviceInfoListModel {
  String title;
  String? name;
  int deviceBatteryStatus;
  DeviceStates deviceStates;
  String deviceImg;
  String? assignedChild;
  String? assignedVehicle;

  DeviceInfoListModel({
    required this.title,
    this.name,
    required this.deviceBatteryStatus,
    this.deviceStates = DeviceStates.disConnected,
    required this.deviceImg,
    this.assignedChild,
    this.assignedVehicle,
  });
}
