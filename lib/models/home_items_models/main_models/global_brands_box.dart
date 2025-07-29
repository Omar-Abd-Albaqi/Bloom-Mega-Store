
import '../general_models/image_model.dart';

class GlobalBrandsBoxModel {
  final int id;
  final ImageModel cover;
  final ImageModel coverApp;
  final List<BrandItem> brands;

  GlobalBrandsBoxModel({
    required this.id,
    required this.cover,
    required this.coverApp,
    required this.brands,
  });

  factory GlobalBrandsBoxModel.fromJson(Map<String, dynamic> json) {
    return GlobalBrandsBoxModel(
      id: json['id'],
      cover: ImageModel.fromJson(json['cover']),
      coverApp: ImageModel.fromJson(json['cover_app']),
      brands: (json['brands'] as List)
          .map((item) => BrandItem.fromJson(item))
          .toList(),
    );
  }
}

class BrandItem {
  final int id;
  final Brand brand;

  BrandItem({
    required this.id,
    required this.brand,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) {
    return BrandItem(
      id: json['id'],
      brand: Brand.fromJson(json['brand']),
    );
  }
}

class Brand {
  final int id;
  final String documentId;
  final String name;
  final String handle;
  final dynamic metada;
  final String medusaId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final String logo;
  final String? category;

  Brand({
    required this.id,
    required this.documentId,
    required this.name,
    required this.handle,
    this.metada,
    required this.medusaId,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.logo,
    this.category
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      documentId: json['documentId'],
      name: json['name'],
      handle: json['handle'],
      metada: json['metada'],
      medusaId: json['medusa_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      publishedAt: DateTime.parse(json['publishedAt']),
      logo: json['logo'],
      category: json['category']
    );
  }
}
