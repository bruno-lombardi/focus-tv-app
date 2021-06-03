import 'package:dartz/dartz.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';

abstract class DeviceRepository {
  Future<Either<Failure, Device>> getDeviceById(String id);
  Future<Either<Failure, Device>> findOrCreateDevice(
      CreateDeviceDTO createDeviceDTO);
}
