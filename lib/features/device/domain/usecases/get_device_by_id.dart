// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/repositories/device_repository.dart';

class GetDeviceById {
  final DeviceRepository deviceRepository;

  GetDeviceById(this.deviceRepository);

  Future<Either<Failure, Device>> execute({required String id}) async {
    return await deviceRepository.getDeviceById(id);
  }
}
