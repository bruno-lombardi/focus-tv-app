// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

class CreateDeviceDTO extends Equatable {
  final String macAddress;
  final String alias;
  final bool? isActive;

  CreateDeviceDTO(
      {required this.macAddress, required this.alias, this.isActive});

  @override
  List<Object> get props => [macAddress];
}
