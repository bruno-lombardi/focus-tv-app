// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:focus_tv_app/features/device/data/repositories/device_repository_impl.dart';
import 'package:focus_tv_app/features/device/data/datasources/device_remote_data_source.dart';

class MockRemoteDataSource extends Mock implements DeviceRemoteDataSource {}

void main() {
  DeviceRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();

    repository = DeviceRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('getDeviceById', () {});
}
