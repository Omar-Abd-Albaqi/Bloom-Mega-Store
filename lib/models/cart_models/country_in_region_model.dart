import 'helper_functions.dart';

class CountryInRegion {
  final String iso2;
  final String iso3;
  final String numCode;
  final String name;
  final String displayName;
  final String regionId;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;


  CountryInRegion({
    required this.iso2,
    required this.iso3,
    required this.numCode,
    required this.name,
    required this.displayName,
    required this.regionId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory CountryInRegion.fromJson(Map<String, dynamic> json) {
    return CountryInRegion(
      iso2: json['iso_2'] as String,
      iso3: json['iso_3'] as String,
      numCode: json['num_code'] as String,
      name: json['name'] as String,
      displayName: json['display_name'] as String,
      regionId: json['region_id'] as String,
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      createdAt: parseDateTime(json['created_at'] as String?),
      updatedAt: parseDateTime(json['updated_at'] as String?),
      deletedAt: parseDateTime(json['deleted_at'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_2': iso2,
      'iso_3': iso3,
      'num_code': numCode,
      'name': name,
      'display_name': displayName,
      'region_id': regionId,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}