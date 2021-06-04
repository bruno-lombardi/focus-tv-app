// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:focus_tv_app/core/error/failure.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_info_plugin/wifi_info_plugin.dart';
import 'package:flutter/services.dart';

abstract class DeviceInfo {
  Future<Either<Failure, String>> getMacAddress();
}

class DeviceInfoManager {
  const DeviceInfoManager();

  Future<WifiInfoWrapper> getWifiDetails() async {
    return await WifiInfoPlugin.wifiDetails;
  }
}

class DeviceInfoImpl implements DeviceInfo {
  final DeviceInfoManager deviceInfoManager;

  DeviceInfoImpl({required this.deviceInfoManager});

  @override
  Future<Either<Failure, String>> getMacAddress() async {
    try {
      var details = await deviceInfoManager.getWifiDetails();
      return Right(details.macAddress);
    } on PlatformException {
      return Left(DeviceInfoFailure());
    }
  }
}
