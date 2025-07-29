import 'package:bloom/models/home_items_models/general_models/collection_model.dart';

import '../general_models/image_model.dart';

class ProductsListProductsModel {
  final int id;
  final String ctaText;
  final String? title;
  final CollectionModel? collection;
  final ImageModel? cover;

  ProductsListProductsModel({
    required this.id,
    required this.ctaText,
     this.title,
    required this.collection,
     this.cover
  });

  factory ProductsListProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsListProductsModel(
      id: json['id'],
      ctaText: json['cta_text'],
      title: json['title'],
      collection: json['collection'] != null ? CollectionModel.fromJson(json['collection']) : null,
      cover:json['cover'] != null ? ImageModel.fromJson(json['cover']) : null,
    );
  }
}
