

import 'package:bloom/models/category_model.dart';

import '../general_models/image_model.dart';

class ProductsProductsCategory {
  final int id;
  final String title;
  final String ctaText;
  final String extraSpace;
  final String view;
  final bool? hideTitle;
  final CategoryModel? category;
  final ImageModel? cover;

  ProductsProductsCategory({
    required this.id,
    required this.title,
    required this.ctaText,
    required this.extraSpace,
    required this.view,
    this.hideTitle,
    this.category,
    this.cover,
  });

  factory ProductsProductsCategory.fromJson(Map<String, dynamic> json) {
    return ProductsProductsCategory(
      id: json['id'],
      title: json['title'],
      ctaText: json['cta_text'],
      extraSpace: json['extra_space'],
      view: json['view'],
      hideTitle: json['hide_title'],
      category: json['category'] != null && json['category'].isNotEmpty
          ? CategoryModel.fromJson(json['category'])
          : null,
      cover: json['cover'] != null ? ImageModel.fromJson(json['cover']) : null,
    );
  }
}
