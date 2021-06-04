// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class DeviceInfoFailure extends Failure {}
