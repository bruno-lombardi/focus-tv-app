// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';
import 'package:focus_tv_app/features/device/domain/usecases/find_or_create_device.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:focus_tv_app/features/device/domain/repositories/device_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  FindOrCreateDevice? usecase;
  MockDeviceRepository? mockDeviceRepository;

  setUp(() {
    mockDeviceRepository = MockDeviceRepository();
    usecase = FindOrCreateDevice(mockDeviceRepository!);
  });

  final CreateDeviceDTO createDeviceDTO =
      CreateDeviceDTO(macAddress: '08:00:27:4B:4F:DE', alias: 'TV01');
  final Device tDevice = Device(
      id: '601590011a497c093c862535',
      alias: 'TV01',
      campaigns: [],
      company: '603aa240c4ff612d47a5b923',
      createdAt: DateTime.now(),
      isActive: true,
      macAddress: '08:00:27:4B:4F:DE',
      updatedAt: DateTime.now());

  test('should get device by id from repository', () async {
    // arrange
    when(mockDeviceRepository!.findOrCreateDevice(createDeviceDTO))
        .thenAnswer((_) async => Right(tDevice));
    // act
    final result = await usecase!(Params(createDeviceDTO: createDeviceDTO));
    // assert
    expect(result, Right(tDevice));
    verify(mockDeviceRepository!.findOrCreateDevice(createDeviceDTO));
    verifyNoMoreInteractions(mockDeviceRepository);
  });
}
