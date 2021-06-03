// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final bool isActive;
  final String title;
  final String company;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime startAt;
  final DateTime? endAt;
  final DateTime? deletedAt;

  Campaign({
    required this.id,
    required this.isActive,
    required this.title,
    required this.company,
    required this.createdAt,
    required this.updatedAt,
    required this.startAt,
    this.endAt,
    this.deletedAt,
  });

  @override
  List<Object> get props => [id, company];
}
