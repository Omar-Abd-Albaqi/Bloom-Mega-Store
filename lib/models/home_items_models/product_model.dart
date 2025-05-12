// class ProductModel {
//   final String id;
//   final String title;
//   final String? subtitle;
//   final String description;
//   final String handle;
//   final bool isGiftCard;
//   final bool discountable;
//   final String thumbnail;
//   final ProductType type;
//   final ProductCollection collection;
//   final List<ProductOption> options;
//   final List<String> tags;
//   final List<ProductImage> images;
//   final List<ProductVariant> variants;
//
//   ProductModel({
//     required this.id,
//     required this.title,
//     this.subtitle,
//     required this.description,
//     required this.handle,
//     required this.isGiftCard,
//     required this.discountable,
//     required this.thumbnail,
//     required this.type,
//     required this.collection,
//     required this.options,
//     required this.tags,
//     required this.images,
//     required this.variants,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       title: json['title'],
//       subtitle: json['subtitle'],
//       description: json['description'],
//       handle: json['handle'],
//       isGiftCard: json['is_giftcard'],
//       discountable: json['discountable'],
//       thumbnail: json['thumbnail'],
//       type: ProductType.fromJson(json['type']),
//       collection: ProductCollection.fromJson(json['collection']),
//       options: (json['options'] as List)
//           .map((e) => ProductOption.fromJson(e))
//           .toList(),
//       tags: List<String>.from(json['tags']),
//       images: (json['images'] as List)
//           .map((e) => ProductImage.fromJson(e))
//           .toList(),
//       variants: (json['variants'] as List)
//           .map((e) => ProductVariant.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class ProductType {
//   final String id;
//   final String value;
//
//   ProductType({required this.id, required this.value});
//
//   factory ProductType.fromJson(Map<String, dynamic> json) {
//     return ProductType(
//       id: json['id'],
//       value: json['value'],
//     );
//   }
// }
//
// class ProductCollection {
//   final String id;
//   final String title;
//   final String handle;
//
//   ProductCollection({
//     required this.id,
//     required this.title,
//     required this.handle,
//   });
//
//   factory ProductCollection.fromJson(Map<String, dynamic> json) {
//     return ProductCollection(
//       id: json['id'],
//       title: json['title'],
//       handle: json['handle'],
//     );
//   }
// }
//
// class ProductOption {
//   final String id;
//   final String title;
//   final List<OptionValue> values;
//
//   ProductOption({
//     required this.id,
//     required this.title,
//     required this.values,
//   });
//
//   factory ProductOption.fromJson(Map<String, dynamic> json) {
//     return ProductOption(
//       id: json['id'],
//       title: json['title'],
//       values: (json['values'] as List)
//           .map((e) => OptionValue.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class OptionValue {
//   final String id;
//   final String value;
//
//   OptionValue({required this.id, required this.value});
//
//   factory OptionValue.fromJson(Map<String, dynamic> json) {
//     return OptionValue(
//       id: json['id'],
//       value: json['value'],
//     );
//   }
// }
//
// class ProductImage {
//   final String id;
//   final String url;
//   final int rank;
//
//   ProductImage({
//     required this.id,
//     required this.url,
//     required this.rank,
//   });
//
//   factory ProductImage.fromJson(Map<String, dynamic> json) {
//     return ProductImage(
//       id: json['id'],
//       url: json['url'],
//       rank: json['rank'],
//     );
//   }
// }
//
// class ProductVariant {
//   final String id;
//   final String title;
//   final bool allowBackorder;
//   final bool manageInventory;
//   final int variantRank;
//   final List<OptionValue> options;
//   final CalculatedPrice? calculatedPrice;
//
//   ProductVariant({
//     required this.id,
//     required this.title,
//     required this.allowBackorder,
//     required this.manageInventory,
//     required this.variantRank,
//     required this.options,
//     this.calculatedPrice,
//   });
//
//   factory ProductVariant.fromJson(Map<String, dynamic> json) {
//     return ProductVariant(
//       id: json['id'],
//       title: json['title'],
//       allowBackorder: json['allow_backorder'],
//       manageInventory: json['manage_inventory'],
//       variantRank: json['variant_rank'],
//       options: (json['options'] as List)
//           .map((e) => OptionValue.fromJson(e))
//           .toList(),
//       calculatedPrice: json['calculated_price'] != null
//           ? CalculatedPrice.fromJson(json['calculated_price'])
//           : null,
//     );
//   }
// }
//
//
//
// class CalculatedPrice {
//   final int calculatedAmount;
//   final int originalAmount;
//   final String currencyCode;
//
//   CalculatedPrice({
//     required this.calculatedAmount,
//     required this.originalAmount,
//     required this.currencyCode,
//   });
//
//   factory CalculatedPrice.fromJson(Map<String, dynamic> json) {
//     return CalculatedPrice(
//       calculatedAmount: json['calculated_amount'],
//       originalAmount: json['original_amount'],
//       currencyCode: json['currency_code'],
//     );
//   }
// }