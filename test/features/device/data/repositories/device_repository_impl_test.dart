// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_tv_app/core/error/exception.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/data/models/device_dto_model.dart';
import 'package:focus_tv_app/features/device/data/models/device_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:focus_tv_app/features/device/data/repositories/device_repository_impl.dart';
import 'package:focus_tv_app/features/device/data/datasources/device_remote_data_source.dart';

class MockRemoteDataSource extends Mock implements DeviceRemoteDataSource {}

void main() {
  DeviceRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();

    repository = DeviceRepositoryImpl(
      remoteDataSource: mockRemoteDataSource!,
    );
  });

  final String tID = '601590011a497c093c862535';
  final CreateDeviceDTOModel createDeviceDTO =
      CreateDeviceDTOModel(macAddress: '08:00:27:4B:4F:DE', alias: 'TV01');
  final DeviceModel tDeviceModel = DeviceModel(
      id: 'any',
      alias: 'TV01',
      campaigns: [],
      company: '603aa240c4ff612d47a5b923',
      createdAt: DateTime.now(),
      isActive: true,
      macAddress: '08:00:27:4B:4F:DE',
      updatedAt: DateTime.now());

  group('getDeviceById', () {
    test(
        'should return remote data when the call to remote data source is sucessful',
        () async {
      when(mockRemoteDataSource!.getDeviceById(any as String))
          .thenAnswer((_) async => Future.value(tDeviceModel));

      final result = await repository!.getDeviceById(tID);
      verify(mockRemoteDataSource!.getDeviceById(tID));
      expect(result, equals(Right(tDeviceModel)));
    });

    test(
        'should return ServerFailure when the call to remote data is unsucessful',
        () async {
      when(mockRemoteDataSource!.getDeviceById(any as String))
          .thenThrow(ServerException(statusCode: 500, code: 'server.error'));
      final result = await repository!.getDeviceById(tID);
      verify(mockRemoteDataSource!.getDeviceById(tID));
      expect(result, equals(Left(ServerFailure())));
    });
    test(
        'should return DeviceNotFoundFailure when the call to remote data returns 404',
        () async {
      when(mockRemoteDataSource!.getDeviceById(any as String)).thenThrow(
          ServerException(
              statusCode: 404,
              code: 'device.notfound',
              message: 'Device not found'));
      final result = await repository!.getDeviceById(tID);
      verify(mockRemoteDataSource!.getDeviceById(tID));
      expect(result,
          equals(Left(DeviceNotFoundFailure(message: 'Device not found'))));
    });
  });
  group('findOrCreateDevice', () {
    test(
        'should return remote data when the call to remote data source is sucessful',
        () async {
      when(mockRemoteDataSource!
              .findOrCreateDevice(any as CreateDeviceDTOModel))
          .thenAnswer((_) async => Future.value(tDeviceModel));

      final result = await repository!.findOrCreateDevice(createDeviceDTO);
      verify(mockRemoteDataSource!.findOrCreateDevice(createDeviceDTO));
      expect(result, equals(Right(tDeviceModel)));
    });

    test(
        'should return server failure when the call to remote data is unsucessful',
        () async {
      when(mockRemoteDataSource!
              .findOrCreateDevice(any as CreateDeviceDTOModel))
          .thenThrow(ServerException(statusCode: 400, code: 'bad.request'));
      final result = await repository!.findOrCreateDevice(createDeviceDTO);
      verify(mockRemoteDataSource!.findOrCreateDevice(createDeviceDTO));
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
