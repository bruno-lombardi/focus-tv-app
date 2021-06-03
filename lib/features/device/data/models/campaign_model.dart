import 'package:focus_tv_app/features/device/domain/entities/campaign.dart';

class CampaignModel extends Campaign {
  final String id;
  final bool isActive;
  final String title;
  final String company;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime startAt;
  final DateTime? endAt;
  final DateTime? deletedAt;

  CampaignModel({
    required this.id,
    required this.isActive,
    required this.title,
    required this.company,
    required this.createdAt,
    required this.updatedAt,
    required this.startAt,
    this.endAt,
    this.deletedAt,
  }) : super(
            id: id,
            isActive: isActive,
            company: company,
            createdAt: createdAt,
            startAt: startAt,
            title: title,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            endAt: endAt);

  factory CampaignModel.fromJson(Map<String, dynamic> data) {
    return CampaignModel(
      id: data['_id'],
      isActive: data['isActive'],
      title: data['title'],
      company: data['company'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      startAt: DateTime.parse(data['startAt']),
      endAt: data['endAt'] != null ? DateTime.parse(data['endAt']) : null,
      deletedAt:
          data['deletedAt'] != null ? DateTime.parse(data['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isActive': isActive,
      'title': title,
      'company': company,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'startAt': startAt.toIso8601String(),
      'endAt': endAt != null ? endAt!.toIso8601String() : endAt,
      'deletedAt': deletedAt != null ? deletedAt!.toIso8601String() : deletedAt,
    };
  }
}
