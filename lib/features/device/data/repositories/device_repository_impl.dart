// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:focus_tv_app/core/error/exception.dart';
import 'package:focus_tv_app/features/device/data/datasources/device_remote_data_source.dart';
import 'package:focus_tv_app/features/device/data/models/device_dto_model.dart';
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
      CreateDeviceDTO createDeviceDTO) async {
    return await _getDevice(() async {
      return remoteDataSource.findOrCreateDevice(CreateDeviceDTOModel(
          macAddress: createDeviceDTO.macAddress,
          alias: createDeviceDTO.alias,
          isActive: createDeviceDTO.isActive));
    });
  }

  @override
  Future<Either<Failure, Device>> getDeviceById(String id) async {
    return await _getDevice(() async {
      return remoteDataSource.getDeviceById(id);
    });
  }

  Future<Either<Failure, Device>> _getDevice(
      Future<Device> Function() findOrGetDevice) async {
    try {
      final deviceModel = await findOrGetDevice();
      return Right(deviceModel);
    } on ServerException catch (ex) {
      if (ex.statusCode == 404) {
        return Left(DeviceNotFoundFailure(message: ex.message));
      }
      return Left(ServerFailure());
    }
  }
}
