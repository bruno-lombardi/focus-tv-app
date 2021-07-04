import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';
import 'package:focus_tv_app/features/device/domain/usecases/find_or_create_device.dart'
    as FOCD;
import 'package:focus_tv_app/features/device/domain/usecases/get_device_by_id.dart'
    as GDBI;
import 'package:meta/meta.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final GDBI.GetDeviceById getDeviceById;
  final FOCD.FindOrCreateDevice findOrCreateDevice;

  DeviceBloc({required this.getDeviceById, required this.findOrCreateDevice})
      : super(DeviceInitial());

  @override
  Stream<DeviceState> mapEventToState(
    DeviceEvent event,
  ) async* {
    if (event is GetDeviceByIdEvent) {
      yield DeviceLoading();
      final failureOrDevice = await getDeviceById(GDBI.Params(id: event.id));
      yield* _eitherLoadedOrErrorState(failureOrDevice);
    } else if (event is FindOrCreateDeviceEvent) {
      yield DeviceLoading();
      final failureOrDevice = await findOrCreateDevice(
          FOCD.Params(createDeviceDTO: event.createDeviceDTO));
      yield* _eitherLoadedOrErrorState(failureOrDevice);
    }
  }

  Stream<DeviceState> _eitherLoadedOrErrorState(
    Either<Failure, Device> either,
  ) async* {
    yield either.fold(
      (failure) => DeviceError(message: _mapFailureToErrorMessage(failure)),
      (device) => DeviceLoaded(device: device),
    );
  }

  String _mapFailureToErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DeviceNotFoundFailure:
        return (failure as DeviceNotFoundFailure).message;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
