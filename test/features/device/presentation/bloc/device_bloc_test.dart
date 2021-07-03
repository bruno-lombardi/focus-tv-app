// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_tv_app/core/error/failure.dart';
import 'package:focus_tv_app/features/device/domain/entities/device.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';
import 'package:focus_tv_app/features/device/domain/usecases/find_or_create_device.dart'
    as FOCD;
import 'package:focus_tv_app/features/device/domain/usecases/get_device_by_id.dart'
    as GDBI;
import 'package:focus_tv_app/features/device/presentation/bloc/device_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';

class MockGetDeviceById extends Mock implements GDBI.GetDeviceById {}

class MockFindOrCreateDevice extends Mock implements FOCD.FindOrCreateDevice {}

void main() {
  DeviceBloc? bloc;
  MockGetDeviceById? getDeviceById;
  MockFindOrCreateDevice? findOrCreateDevice;

  setUp(() {
    getDeviceById = MockGetDeviceById();
    findOrCreateDevice = MockFindOrCreateDevice();

    bloc = DeviceBloc(
        getDeviceById: getDeviceById!, findOrCreateDevice: findOrCreateDevice!);
  });

  test('should initialize with device initial state', () {
    expect(bloc!.initialState, equals(DeviceInitial()));
  });

  group('getDeviceById usecase', () {
    final String tID = '601590011a497c093c862535';
    final Device tDevice = Device(
        id: tID,
        alias: 'TV01',
        campaigns: [],
        company: '603aa240c4ff612d47a5b923',
        createdAt: DateTime.now(),
        isActive: true,
        macAddress: '08:00:27:4B:4F:DE',
        updatedAt: DateTime.now());

    test('should call usecase with correct params', () async {
      when(getDeviceById!(any as GDBI.Params))
          .thenAnswer((_) async => Right(tDevice));

      bloc!.dispatch(GetDeviceByIdEvent(id: tID));
      await untilCalled(getDeviceById!(any as GDBI.Params));

      verify(getDeviceById!(GDBI.Params(id: tID)));
    });

    test(
        'should emit [DeviceInitial, DeviceLoading, DeviceLoaded] when device is found',
        () async {
      when(getDeviceById!(any as GDBI.Params))
          .thenAnswer((_) async => Right(tDevice));

      final expected = [
        DeviceInitial(),
        DeviceLoading(),
        DeviceLoaded(device: tDevice)
      ];
      expectLater(bloc!.state, emitsInOrder(expected));
      bloc!.dispatch(GetDeviceByIdEvent(id: tID));
    });

    test(
        'should emit [DeviceInitial, DeviceLoading, DeviceError] when server failure with proper message',
        () async {
      when(getDeviceById!(any as GDBI.Params))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        DeviceInitial(),
        DeviceLoading(),
        DeviceError(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc!.state, emitsInOrder(expected));
      bloc!.dispatch(GetDeviceByIdEvent(id: tID));
    });
    test(
        'should emit [DeviceInitial, DeviceLoading, DeviceError] when device is not found with proper message',
        () async {
      when(getDeviceById!(any as GDBI.Params)).thenAnswer((_) async =>
          Left(DeviceNotFoundFailure(message: DEVICE_NOT_FOUND_MESSAGE)));

      final expected = [
        DeviceInitial(),
        DeviceLoading(),
        DeviceError(message: DEVICE_NOT_FOUND_MESSAGE)
      ];
      expectLater(bloc!.state, emitsInOrder(expected));
      bloc!.dispatch(GetDeviceByIdEvent(id: tID));
    });
  });

  group('findOrCreateDevice usecase', () {
    final tCreateDeviceDto =
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

    test('should call usecase with correct params', () async {
      when(findOrCreateDevice!(any as FOCD.Params))
          .thenAnswer((_) async => Right(tDevice));

      bloc!
          .dispatch(FindOrCreateDeviceEvent(createDeviceDTO: tCreateDeviceDto));
      await untilCalled(findOrCreateDevice!(any as FOCD.Params));

      verify(
          findOrCreateDevice!(FOCD.Params(createDeviceDTO: tCreateDeviceDto)));
    });

    test(
        'should emit [DeviceInitial, DeviceLoading, DeviceLoaded] when device is found',
        () async {
      when(findOrCreateDevice!(any as FOCD.Params))
          .thenAnswer((_) async => Right(tDevice));

      final expected = [
        DeviceInitial(),
        DeviceLoading(),
        DeviceLoaded(device: tDevice)
      ];
      expectLater(bloc!.state, emitsInOrder(expected));
      bloc!
          .dispatch(FindOrCreateDeviceEvent(createDeviceDTO: tCreateDeviceDto));
    });

    test(
        'should emit [DeviceInitial, DeviceLoading, DeviceError] when server failure with proper message',
        () async {
      when(findOrCreateDevice!(any as FOCD.Params))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        DeviceInitial(),
        DeviceLoading(),
        DeviceError(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc!.state, emitsInOrder(expected));
      bloc!
          .dispatch(FindOrCreateDeviceEvent(createDeviceDTO: tCreateDeviceDto));
    });
    test(
        'should emit [DeviceInitial, DeviceLoading, DeviceError] when device is not found with proper message',
        () async {
      when(findOrCreateDevice!(any as FOCD.Params)).thenAnswer((_) async =>
          Left(DeviceNotFoundFailure(message: DEVICE_NOT_FOUND_MESSAGE)));

      final expected = [
        DeviceInitial(),
        DeviceLoading(),
        DeviceError(message: DEVICE_NOT_FOUND_MESSAGE)
      ];
      expectLater(bloc!.state, emitsInOrder(expected));
      bloc!
          .dispatch(FindOrCreateDeviceEvent(createDeviceDTO: tCreateDeviceDto));
    });
  });
}
