part of 'device_bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String DEVICE_NOT_FOUND_MESSAGE = 'Device not found';

@immutable
abstract class DeviceState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceLoaded extends DeviceState {
  final Device device;

  DeviceLoaded({required this.device});

  @override
  List<Object> get props => [device];
}

class DeviceError extends DeviceState {
  final String message;

  DeviceError({required this.message});

  @override
  List<Object> get props => [message];
}
