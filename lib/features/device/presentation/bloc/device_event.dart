part of 'device_bloc.dart';

@immutable
abstract class DeviceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDeviceByIdEvent extends DeviceEvent {
  final String id;

  GetDeviceByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FindOrCreateDeviceEvent extends DeviceEvent {
  final CreateDeviceDTO createDeviceDTO;

  FindOrCreateDeviceEvent({required this.createDeviceDTO});

  @override
  List<Object> get props => [createDeviceDTO];
}
