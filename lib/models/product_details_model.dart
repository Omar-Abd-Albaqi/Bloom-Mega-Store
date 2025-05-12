import 'local_storage_models/product_model/product_model.dart';

class ProductDetailsModel {
  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final String handle;
  final bool isGiftcard;
  final String thumbnail;
  final bool discountable;
  final String? status;
  final Map<String, dynamic> metadata;
  final List<Category>? categories;
  final Profile? profile;
  final List<Profile>? profiles;
  final Collection? collection;
  final ProductType type;
  final List<Tag> tags;
  final List<ProductImage> images;
  final List<Option> options;
  final List<SalesChannel>? salesChannels;
  final List<Variant> variants;

  ProductDetailsModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    required this.handle,
    required this.isGiftcard,
    required this.thumbnail,
    required this.discountable,
     this.status,
    required this.metadata,
    this.categories,
     this.profile,
     this.profiles,
     this.collection,
    required this.type,
    required this.tags,
    required this.images,
    required this.options,
     this.salesChannels,
    required this.variants,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      handle: json['handle'],
      isGiftcard: json['is_giftcard'],
      thumbnail: json['thumbnail'],
      discountable: json['discountable'],
      status: json['status'],
      metadata: json['metadata'] ?? {},
      categories: json['categories'] != null
          ? (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList()
          : null,
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      profiles:json['profiles'] != null ?
      (json['profiles'] as List).map((e) => Profile.fromJson(e)).toList() : null,
      collection: Collection.fromJson(json['collection'] ?? {}),
      type: ProductType.fromJson(json['type']),
      tags: (json['tags'] as List).map((e) => Tag.fromJson(e)).toList(),
      images:
      (json['images'] as List).map((e) => ProductImage.fromJson(e)).toList(),
      options: (json['options'] as List).map((e) => Option.fromJson(e)).toList(),
      salesChannels: json['sales_channels'] != null ? (json['sales_channels'] as List)
          .map((e) => SalesChannel.fromJson(e))
          .toList() : null,
      variants: (json['variants'] as List).map((e) => Variant.fromJson(e)).toList(),
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Profile {
  final String id;
  final String name;

  Profile({required this.id, required this.name});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Collection {
  final String? id;
  final String? title;

  Collection({ this.id,  this.title});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] ??"",
      title: json['title'] ??"",
    );
  }
}

class ProductType {
  final String id;
  final String value;

  ProductType({required this.id, required this.value});

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      value: json['value'],
    );
  }
}

class Tag {
  final String id;
  final String value;

  Tag({required this.id, required this.value});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      value: json['value'],
    );
  }
}


class Option {
  final String id;
  final String title;

  Option({required this.id, required this.title});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      title: json['title'],
    );
  }
}

class SalesChannel {
  final String id;
  final String name;

  SalesChannel({required this.id, required this.name});

  factory SalesChannel.fromJson(Map<String, dynamic> json) {
    return SalesChannel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Variant {
  final String id;
  final String title;
  final bool allowBackorder;
  final bool manageInventory;
  final String? sku;
  final int? inventoryQuantity;
  final String? currencyCode;
  final String? variantRank;
  final List<VariantOption>? options;
  final CalculatedPrice? calculatedPrice;

  Variant({
    required this.id,
    required this.title,
    required this.allowBackorder,
    required this.manageInventory,
    this.sku,
    this.inventoryQuantity,
    this.currencyCode,
    this.variantRank,
    this.options,
    this.calculatedPrice,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      title: json['title'],
      allowBackorder: json['allow_backorder'],
      manageInventory: json['manage_inventory'],
      sku: json['sku'],
      inventoryQuantity: json['inventory_quantity'],
      currencyCode: json['calculated_price']?['currency_code'],
      variantRank: json['variant_rank']?.toString(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => VariantOption.fromJson(e))
          .toList(),
      calculatedPrice: json['calculated_price'] != null
          ? CalculatedPrice.fromJson(json['calculated_price'])
          : null,
    );
  }
}

class VariantOption {
  final String id;
  final String value;
  final String optionId;
  final OptionDetail? option;

  VariantOption({
    required this.id,
    required this.value,
    required this.optionId,
    this.option,
  });

  factory VariantOption.fromJson(Map<String, dynamic> json) {
    return VariantOption(
      id: json['id'],
      value: json['value'],
      optionId: json['option_id'],
      option: json['option'] != null
          ? OptionDetail.fromJson(json['option'])
          : null,
    );
  }
}

class OptionDetail {
  final String id;
  final String title;

  OptionDetail({
    required this.id,
    required this.title,
  });

  factory OptionDetail.fromJson(Map<String, dynamic> json) {
    return OptionDetail(
      id: json['id'],
      title: json['title'],
    );
  }
}

class CalculatedPrice {
  final int calculatedAmount;
  final int originalAmount;
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

