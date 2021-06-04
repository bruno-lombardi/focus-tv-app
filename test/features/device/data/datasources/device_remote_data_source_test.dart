// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:focus_tv_app/core/error/exception.dart';
import 'package:focus_tv_app/features/device/data/datasources/device_remote_data_source.dart';
import 'package:focus_tv_app/features/device/data/models/device_dto_model.dart';
import 'package:focus_tv_app/features/device/data/models/device_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  DeviceRemoteDataSourceImpl? dataSource;
  MockHttpClient? mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = DeviceRemoteDataSourceImpl(client: mockHttpClient!);
  });

  group('getDeviceById', () {
    final tID = '60a6de535a166b22fa895cc5';
    final tDeviceFixture = json.decode(fixture('device.json'));

    final tDeviceModel = DeviceModel.fromJson(tDeviceFixture['device']);

    void setupMockHttpClientSuccess200() {
      when(mockHttpClient!.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('device.json'), 200),
      );
    }

    void setupMockHttpClientNotFound404() {
      when(mockHttpClient!.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('error_404.json'), 404),
      );
    }

    test(
        'should perform GET request on API URL with the id in the url path param',
        () async {
      setupMockHttpClientSuccess200();
      dataSource!.getDeviceById(tID);

      verify(mockHttpClient!.get('https://api.sayrodigital.com/v1/device/$tID',
          headers: {'Content-Type': 'application/json'}));
    });
    test('should return DeviceModel when the response is 200 (success)',
        () async {
      setupMockHttpClientSuccess200();
      final result = await dataSource!.getDeviceById(tID);

      expect(result, equals(tDeviceModel));
    });
    test('should throw ServerException when the response is 404 (not found)',
        () async {
      setupMockHttpClientNotFound404();
      final call = dataSource!.getDeviceById;

      expect(() => call(tID), throwsA(TypeMatcher<ServerException>()));
    });
  });
  group('findOrCreateDevice', () {
    final tDeviceFixture = json.decode(fixture('device.json'));

    final tDeviceModel = DeviceModel.fromJson(tDeviceFixture['device']);
    final tCreateDeviceDTOModel =
        CreateDeviceDTOModel(macAddress: 'D4:AB:CD:C5:F7:B4', alias: 'TV01');

    void setupMockHttpClientSuccess200() {
      when(mockHttpClient!
              .post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
        (_) async => http.Response(fixture('device.json'), 200),
      );
    }

    void setupMockHttpClientNotFound404() {
      when(mockHttpClient!
              .post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
        (_) async => http.Response(fixture('error_404.json'), 404),
      );
    }

    test('should perform POST request on API URL with the createDeviceDTO body',
        () async {
      setupMockHttpClientSuccess200();
      dataSource!.findOrCreateDevice(tCreateDeviceDTOModel);

      verify(mockHttpClient!.post('https://api.sayrodigital.com/v1/device',
          headers: {'Content-Type': 'application/json'},
          body: {'device': tCreateDeviceDTOModel.toJson()}));
    });
    test('should return DeviceModel when the response is 200 (success)',
        () async {
      setupMockHttpClientSuccess200();
      final result =
          await dataSource!.findOrCreateDevice(tCreateDeviceDTOModel);

      expect(result, equals(tDeviceModel));
    });
    test('should throw ServerException when the response is 404 (not found)',
        () async {
      setupMockHttpClientNotFound404();
      final call = dataSource!.findOrCreateDevice;

      expect(() => call(tCreateDeviceDTOModel),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
}
