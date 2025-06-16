
import 'package:hive_flutter/adapters.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? subtitle;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String handle;

  @HiveField(5)
  final bool isGiftCard;

  @HiveField(6)
  final bool discountable;

  @HiveField(7)
  final String thumbnail;

  @HiveField(8)
  final ProductType type;

  @HiveField(9)
  final ProductCollection? collection;

  @HiveField(10)
  final List<ProductOption> options;

  @HiveField(11)
  final List<String> tags;

  @HiveField(12)
  final List<ProductImage> images;

  @HiveField(13)
  final List<ProductVariant> variants;

  ProductModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    required this.handle,
    required this.isGiftCard,
    required this.discountable,
    required this.thumbnail,
    required this.type,
     this.collection,
    required this.options,
    required this.tags,
    required this.images,
    required this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      handle: json['handle'],
      isGiftCard: json['is_giftcard'],
      discountable: json['discountable'],
      thumbnail: json['thumbnail'],
      type: ProductType.fromJson(json['type']),
      collection: ProductCollection.fromJson(json['collection'] ?? {}),
      options: (json['options'] as List)
          .map((e) => ProductOption.fromJson(e))
          .toList(),
      tags: List<String>.from(json['tags']),
      images: (json['images'] as List)
          .map((e) => ProductImage.fromJson(e))
          .toList(),
      variants: (json['variants'] as List)
          .map((e) => ProductVariant.fromJson(e))
          .toList(),
    );
  }
}

@HiveType(typeId: 1)
class ProductVariant extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool allowBackorder;

  @HiveField(3)
  final bool manageInventory;

  @HiveField(4)
  final int variantRank;

  @HiveField(5)
  final List<OptionValue> options;

  @HiveField(6)
  final CalculatedPrice? calculatedPrice;

  ProductVariant({
    required this.id,
    required this.title,
    required this.allowBackorder,
    required this.manageInventory,
    required this.variantRank,
    required this.options,
    this.calculatedPrice,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      title: json['title'],
      allowBackorder: json['allow_backorder'],
      manageInventory: json['manage_inventory'],
      variantRank: json['variant_rank'],
      options: (json['options'] as List)
          .map((e) => OptionValue.fromJson(e))
          .toList(),
      calculatedPrice: json['calculated_price'] != null
          ? CalculatedPrice.fromJson(json['calculated_price'])
          : null,
    );
  }

  @override
  String toString() {
    return 'ProductVariant{id: $id, title: $title, allowBackorder: $allowBackorder, manageInventory: $manageInventory, variantRank: $variantRank, options: $options, calculatedPrice: $calculatedPrice}';
  }
}

@HiveType(typeId: 2)
class OptionValue extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String value;

  OptionValue({
    required this.id,
    required this.value,
  });

  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(
      id: json['id'],
      value: json['value'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionValue &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          value == other.value;

  @override
  int get hashCode => id.hashCode ^ value.hashCode;

}

@HiveType(typeId: 3)
class ProductType extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String value;

  ProductType({required this.id, required this.value});

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      value: json['value'],
    );
  }
}

@HiveType(typeId: 4)
class ProductCollection extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? handle;

  ProductCollection({
     this.id,
     this.title,
     this.handle,
  });

  factory ProductCollection.fromJson(Map<String, dynamic> json) {
    return ProductCollection(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      handle: json['handle'] ?? "",
    );
  }
}

@HiveType(typeId: 5)
class ProductOption extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<OptionValue> values;

  ProductOption({
    required this.id,
    required this.title,
    required this.values,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(
      id: json['id'],
      title: json['title'],
      values: (json['values'] as List)
          .map((e) => OptionValue.fromJson(e))
          .toList(),
    );
  }
}

@HiveType(typeId: 6)
class ProductImage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final int rank;

  ProductImage({
    required this.id,
    required this.url,
    required this.rank,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      url: json['url'],
      rank: json['rank'],
    );
  }
}

@HiveType(typeId: 7)
class CalculatedPrice extends HiveObject {
  @HiveField(0)
  final int calculatedAmount;

  @HiveField(1)
  final int originalAmount;

  @HiveField(2)
  final String currencyCode;

  CalculatedPrice({
    required this.calculatedAmount,
    required this.originalAmount,
    required this.currencyCode,
  });

  factory CalculatedPrice.fromJson(Map<String, dynamic> json) {
    return CalculatedPrice(
      calculatedAmount: json['calculated_amount'],
      originalAmount: json['original_amount'],
      currencyCode: json['currency_code'],
    );
  }
}

