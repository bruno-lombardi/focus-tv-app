// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:focus_tv_app/core/error/exception.dart';
import 'package:focus_tv_app/features/device/data/models/device_dto_model.dart';
import 'package:http/http.dart' as http;
import 'package:focus_tv_app/features/device/data/models/device_model.dart';
import 'package:focus_tv_app/features/device/domain/entities/device_dto.dart';

abstract class DeviceRemoteDataSource {
  Future<DeviceModel> getDeviceById(String id);
  Future<DeviceModel> findOrCreateDevice(CreateDeviceDTOModel createDeviceDTO);
}

class DeviceRemoteDataSourceImpl implements DeviceRemoteDataSource {
  final http.Client client;

  DeviceRemoteDataSourceImpl({required this.client});

  @override
  Future<DeviceModel> findOrCreateDevice(
      CreateDeviceDTOModel createDeviceDTOModel) async {
    return await _getDeviceFromRequest(() async {
      return client.post('https://api.sayrodigital.com/v1/device',
          headers: {'Content-Type': 'application/json'},
          body: {'device': createDeviceDTOModel.toJson()});
    });
  }

  @override
  Future<DeviceModel> getDeviceById(String id) async {
    return await _getDeviceFromRequest(() async {
      return client.get('https://api.sayrodigital.com/v1/device/$id',
          headers: {'Content-Type': 'application/json'});
    });
  }

  Future<DeviceModel> _getDeviceFromRequest(
      Future<http.Response> Function() request) async {
    final response = await request();
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = json.decode(response.body);
      return DeviceModel.fromJson(body['device']);
    } else {
      throw ServerException();
    }
  }
}
