import 'package:focus_tv_app/core/device_info/device_info.dart';
import 'package:focus_tv_app/features/device/data/datasources/device_remote_data_source.dart';
import 'package:focus_tv_app/features/device/data/repositories/device_repository_impl.dart';
import 'package:focus_tv_app/features/device/domain/repositories/device_repository.dart';
import 'package:focus_tv_app/features/device/domain/usecases/find_or_create_device.dart';
import 'package:focus_tv_app/features/device/domain/usecases/get_device_by_id.dart';
import 'package:focus_tv_app/features/device/presentation/bloc/device_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  // Features - Device
  sl.registerFactory(
      () => DeviceBloc(getDeviceById: sl(), findOrCreateDevice: sl()));

  // Usecases
  sl.registerLazySingleton<GetDeviceById>(() => GetDeviceById(sl()));
  sl.registerLazySingleton<FindOrCreateDevice>(() => FindOrCreateDevice(sl()));

  // Repositories
  sl.registerLazySingleton<DeviceRepository>(
      () => DeviceRepositoryImpl(remoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<DeviceRemoteDataSource>(
      () => DeviceRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<DeviceInfo>(
      () => DeviceInfoImpl(deviceInfoManager: sl()));
  sl.registerLazySingleton<DeviceInfoManager>(() => DeviceInfoManager());
}
