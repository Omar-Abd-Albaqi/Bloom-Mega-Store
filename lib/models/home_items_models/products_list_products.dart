import 'package:bloom/models/home_items_models/collection_model.dart';

class ProductsListProductsModel {
  final int id;
  final String type;
  final String legend;
  final String ctaLink;
  final String ctaText;
  final String title;
  final String extraSpace;
  final CollectionModel? collection;

  ProductsListProductsModel({
    required this.id,
    required this.type,
    required this.legend,
    required this.ctaLink,
    required this.ctaText,
    required this.title,
    required this.extraSpace,
    required this.collection,
  });

  factory ProductsListProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsListProductsModel(
      id: json['id'],
      type: json['type'] ?? "",
      legend: json['legend'] ??"",
      ctaLink: json['cta_link'] ??"",
      ctaText: json['cta_text'],
      title: json['title'],
      extraSpace: json['extra_space'],
      collection: json['collection'] != null ? CollectionModel.fromJson(json['collection']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'legend': legend,
      'cta_link': ctaLink,
      'cta_text': ctaText,
      'title': title,
      'extra_space': extraSpace,
      'collection': collection,
    };
  }
}
