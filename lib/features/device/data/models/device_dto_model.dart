import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';

class CreateDeviceDTOModel extends CreateDeviceDTO {
  final String macAddress;
  final String alias;
  final bool? isActive;

  CreateDeviceDTOModel(
      {required this.macAddress, required this.alias, this.isActive})
      : super(alias: alias, macAddress: macAddress, isActive: isActive);

  Map<String, dynamic> toJson() {
    return {'macAddress': macAddress, 'alias': alias, 'isActive': isActive};
  }
}
