import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:focus_tv_app/features/device/data/models/device_model.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tDeviceModel = DeviceModel(
      id: '60a6de535a166b22fa895cc5',
      alias: 'TV01',
      campaigns: [],
      company: '603aa240c4ff612d47a5b923',
      createdAt: DateTime.parse('2021-05-20T22:10:27.782Z'),
      isActive: true,
      macAddress: 'D4:AB:CD:C5:F7:B4',
      updatedAt: DateTime.parse('2021-05-27T18:35:54.841Z'));
  test('should be a subclass of Device entity', () async {
    expect(tDeviceModel, isA<Device>());
  });

  group('fromJson', () {
    test('should return a valid model when having a list of campaigns',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('device.json'));
      final result = DeviceModel.fromJson(jsonMap);

      expect(result.id, tDeviceModel.id);
      expect(result.alias, tDeviceModel.alias);
    });
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tDeviceModel.toJson();
        // assert
        final Map<String, dynamic> expectedJsonMap =
            json.decode(fixture('device.json'));
        expect(result['id'], expectedJsonMap['id']);
        expect(result['alias'], expectedJsonMap['alias']);
        expect(result['createdAt'], expectedJsonMap['createdAt']);
      },
    );
  });
}
