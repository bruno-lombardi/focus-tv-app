// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/core/usecase/usecase.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/repositories/device_repository.dart';

class GetDeviceById extends UseCase<Device, Params> {
  final DeviceRepository deviceRepository;

  GetDeviceById(this.deviceRepository);

  Future<Either<Failure, Device>> call(Params params) async {
    return await deviceRepository.getDeviceById(params.id);
  }
}

class Params extends Equatable {
  final String id;
  Params({required this.id});

  @override
  List<Object> get props => [id];
}
