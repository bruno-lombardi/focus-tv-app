import 'package:focus_tv_app/features/device/data/models/device_model.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';

abstract class DeviceRemoteDataSource {
  Future<DeviceModel> getDeviceById(String id);
  Future<DeviceModel> findOrCreateDevice(CreateDeviceDTO createDeviceDTO);
}
