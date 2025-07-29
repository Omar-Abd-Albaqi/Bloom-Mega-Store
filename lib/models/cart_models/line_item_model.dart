// You may want to put these in separate files, e.g., models/line_item.dart

import '../home_items_models/main_models/products_categories.dart';

class LineItem {
  final String id;
  final String title;
  final int quantity;
  final int unitPrice;
  final String? thumbnail;
  final String variantId;
  final String productId;
  final String? productDescription;
  final String? productHandle;
  final String? productCollection;
  final bool requiresShipping;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductInfo product; // Using a nested model for cleaner code
  final Map<String, dynamic> metadata;

  LineItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    this.thumbnail,
    required this.variantId,
    required this.productId,
    this.productDescription,
    this.productHandle,
    this.productCollection,
    required this.requiresShipping,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.metadata,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'] as String,
      title: json['title'] as String,
      quantity: json['quantity'] as int,
      unitPrice: json['unit_price'] as int,
      thumbnail: json['thumbnail'] as String?,
      variantId: json['variant_id'] as String,
      productId: json['product_id'] as String,
      productDescription: json['product_description'] as String?,
      productHandle: json['product_handle'] as String?,
      productCollection: json['product_collection'] as String?,
      requiresShipping: json['requires_shipping'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      product: ProductInfo.fromJson(json['product'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'unit_price': unitPrice,
      'thumbnail': thumbnail,
      'variant_id': variantId,
      'product_id': productId,
      'product_description': productDescription,
      'product_handle': productHandle,
      'product_collection': productCollection,
      'requires_shipping': requiresShipping,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'product': product.toJson(),
      'metadata': metadata,
    };
  }


  LineItem copyWith({
    String? id,
    String? title,
    int? quantity,
    int? unitPrice,
    String? thumbnail,
    String? variantId,
    String? productId,
    String? productDescription,
    String? productHandle,
    String? productCollection,
    bool? requiresShipping,
    DateTime? createdAt,
    DateTime? updatedAt,
    ProductInfo? product,
    Map<String, dynamic>? metadata,
  }) {
    return LineItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      thumbnail: thumbnail ?? this.thumbnail,
      variantId: variantId ?? this.variantId,
      productId: productId ?? this.productId,
      productDescription: productDescription ?? this.productDescription,
      productHandle: productHandle ?? this.productHandle,
      productCollection: productCollection ?? this.productCollection,
      requiresShipping: requiresShipping ?? this.requiresShipping,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
      metadata: metadata ?? this.metadata,
    );
  }


  @override
  String toString() {
    return 'LineItem{id: $id, title: $title, quantity: $quantity, thumbnail: $thumbnail}';
  }
}

// --- Sub-model for the nested 'product' object ---

class ProductInfo {
  final String id;
  final String? collectionId;
  final String? typeId;
  final List<ProductCategory> categories;

  ProductInfo({
    required this.id,
    this.collectionId,
    this.typeId,
    required this.categories,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'] as String,
      collectionId: json['collection_id'] as String?,
      typeId: json['type_id'] as String?,
      // Safely parse the list of categories
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((categoryJson) => ProductCategory.fromJson(categoryJson as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collection_id': collectionId,
      'type_id': typeId,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}


// class ProductCategory {
//   final String id;
//
//   ProductCategory({required this.id});
//
//   factory ProductCategory.fromJson(Map<String, dynamic> json) {
//     return ProductCategory(
//       id: json['id'] as String,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//     };
//   }
// }