class CollectionModel {
  final String id;
  final String? name;
  final String? handle;
  final String? medusaId;
  final Map<String, dynamic>? metadata;

  CollectionModel({
    required this.id,
     this.name,
     this.handle,
     this.medusaId,
     this.metadata,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'].toString(),
      name: json['name'],
      handle: json['handle'],
      medusaId: json['medusa_id'],
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

}