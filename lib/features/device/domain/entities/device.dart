// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:focus_tv_app/features/device/domain/entities/campaign.dart';

class Device extends Equatable {
  final String id;
  final String macAddress;
  final String alias;
  final String company;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final List<Campaign> campaigns;

  Device(
      {required this.id,
      required this.macAddress,
      required this.alias,
      required this.company,
      required this.createdAt,
      required this.updatedAt,
      required this.campaigns,
      required this.isActive});

  @override
  List<Object> get props => [id, macAddress];

  factory Device.fromJson(Map<String, dynamic> data) {
    List<Campaign> campaignsList = data.containsKey('campaigns')
        ? data['campaigns'].map((c) => Campaign.fromJson(c)).toList()
        : List.empty();
    return Device(
        id: data['_id'],
        macAddress: data['macAddress'],
        alias: data['alias'],
        company: data['company'],
        campaigns: campaignsList,
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['updatedAt']),
        isActive: data['isActive']);
  }
}
