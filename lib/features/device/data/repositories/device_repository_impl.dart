// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:focus_tv_app/features/device/data/datasources/device_remote_data_source.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceRemoteDataSource remoteDataSource;

  DeviceRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Device>> findOrCreateDevice(
      CreateDeviceDTO createDeviceDTO) {
    // TODO: implement findOrCreateDevice
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Device>> getDeviceById(String id) {
    // TODO: implement getDeviceById
    throw UnimplementedError();
  }
}
