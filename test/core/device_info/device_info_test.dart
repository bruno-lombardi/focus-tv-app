// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:focus_tv_app/core/error/failure.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_tv_app/core/device_info/device_info.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wifi_info_plugin/wifi_info_plugin.dart';

class MockDeviceInfoManager extends Mock implements DeviceInfoManager {}

void main() {
  final String tMacAddress = 'D4:AB:CD:C5:F7:B4';
  DeviceInfoManager? deviceInfoManager;
  DeviceInfoImpl? deviceInfo;

  setUp(() {
    deviceInfoManager = MockDeviceInfoManager();
    deviceInfo = DeviceInfoImpl(deviceInfoManager: deviceInfoManager!);
  });

  group('getMacAddress', () {
    test('should return mac address if it is avaiable', () async {
      when(deviceInfoManager!.getWifiDetails()).thenAnswer((_) => Future.value(
          WifiInfoWrapper.withMap({'MACADDRESS': 'D4:AB:CD:C5:F7:B4'})));

      final result = await deviceInfo!.getMacAddress();
      verify(deviceInfoManager!.getWifiDetails());
      expect(result, equals(Right(tMacAddress)));
    });
    test('should return failure if mac address not available', () async {
      when(deviceInfoManager!.getWifiDetails())
          .thenThrow(PlatformException(code: 'MAC_ADDRESS_FAIL'));

      final result = await deviceInfo!.getMacAddress();
      verify(deviceInfoManager!.getWifiDetails());
      expect(result, equals(Left(DeviceInfoFailure())));
    });
  });
}
