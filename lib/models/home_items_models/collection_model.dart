class CollectionModel {
  final String id;
  final String title;
  final String handle;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final Map<String, dynamic> metadata;

  CollectionModel({
    required this.id,
    required this.title,
    required this.handle,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.metadata,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id']?.toString() ?? '', // Added null-aware operator for safety
      title: json['title'] ?? '',
      handle: json['handle'] ?? '',
      createdAt: json['created_at'] != null && json['created_at'].toString().isNotEmpty
          ? DateTime.tryParse(json['created_at'].toString()) // Use tryParse for robustness
          : null,
      updatedAt: json['updated_at'] != null && json['updated_at'].toString().isNotEmpty
          ? DateTime.tryParse(json['updated_at'].toString()) // Use tryParse for robustness
          : null,
      deletedAt: json['deleted_at'] != null && json['deleted_at'].toString().isNotEmpty
          ? DateTime.tryParse(json['deleted_at'].toString()) // Use tryParse for robustness
          : null,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {}, // Ensure metadata is a Map
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'handle': handle,
      'created_at': createdAt?.toIso8601String(), // Added null-aware operator
      'updated_at': updatedAt?.toIso8601String(), // Added null-aware operator
      'deleted_at': deletedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }
}