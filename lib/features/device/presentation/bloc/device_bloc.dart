import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';
import 'package:focus_tv_app/features/device/domain/usecases/find_or_create_device.dart';
import 'package:focus_tv_app/features/device/domain/usecases/get_device_by_id.dart'
    as GDBI;
import 'package:meta/meta.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final GDBI.GetDeviceById getDeviceById;
  final FindOrCreateDevice findOrCreateDevice;

  DeviceBloc({required this.getDeviceById, required this.findOrCreateDevice})
      : super();

  @override
  Stream<DeviceState> mapEventToState(
    DeviceEvent event,
  ) async* {
    if (event is GetDeviceByIdEvent) {
      yield DeviceLoading();
      final failureOrDevice = await getDeviceById(GDBI.Params(id: event.id));
      yield failureOrDevice.fold(
          (failure) => DeviceError(message: _mapFailureToErrorMessage(failure)),
          (device) => DeviceLoaded(device: device));
    }
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

  @override
  DeviceState get initialState => DeviceInitial();
}
