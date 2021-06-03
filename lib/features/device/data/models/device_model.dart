import 'package:focus_tv_app/features/device/domain/entities/device.dart';

import 'campaign_model.dart';

class DeviceModel extends Device {
  final String id;
  final String macAddress;
  final String alias;
  final String company;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final List<CampaignModel> campaigns;

  DeviceModel(
      {required this.id,
      required this.macAddress,
      required this.alias,
      required this.company,
      required this.createdAt,
      required this.updatedAt,
      required this.campaigns,
      required this.isActive})
      : super(
            id: id,
            macAddress: macAddress,
            alias: alias,
            company: company,
            createdAt: createdAt,
            updatedAt: updatedAt,
            campaigns: campaigns,
            isActive: isActive);

  factory DeviceModel.fromJson(Map<String, dynamic> data) {
    var campaignsMap = new List<Map<String, dynamic>>.from(data['campaigns']);

    List<CampaignModel> campaignsList =
        campaignsMap.map((c) => CampaignModel.fromJson(c)).toList();
    return DeviceModel(
        id: data['_id'],
        macAddress: data['macAddress'],
        alias: data['alias'],
        company: data['company'],
        campaigns: campaignsList,
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['updatedAt']),
        isActive: data['isActive']);
  }

  Map<String, dynamic> toJson() {
    var campaignsMap = campaigns.map((c) => c.toJson()).toList();

    return {
      '_id': id,
      'macAddress': macAddress,
      'alias': alias,
      'company': company,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'campaigns': campaignsMap,
      'isActive': isActive
    };
  }
}
