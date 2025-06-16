// import 'package:bloom/models/local_storage_models/product_model/product_model.dart';
//
// import '../../region_model.dart';
//
// class Cart {
//   final String id;
//   final String? email;
//   final String? billingAddressId;
//   final String? shippingAddressId;
//   final String regionId;
//   final String? customerId;
//   final Map<String, dynamic>? customer; // Kept as Map, API shows circular ref placeholder
//   final PaymentSession? paymentSession;
//   final String? paymentId;
//   final Payment? payment;
//   final DateTime? completedAt;
//   final DateTime? paymentAuthorizedAt;
//   final String? salesChannelId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final int? shippingTotal;
//   final int? discountTotal;
//   final int? itemTaxTotal; // API sample has item_tax_total
//   final int? shippingTaxTotal;
//   final int? taxTotal;
//   final int? refundedTotal;
//   final int? total;
//   final int? subtotal;
//   final int? refundableAmount;
//   final int? giftCardTotal;
//   final int? giftCardTaxTotal;
//   final List<PaymentSession>? paymentSessions;
//   final CartType type;
//   final String? idempotencyKey;
//   final Map<String, dynamic>? context;
//   final Map<String, dynamic>? metadata;
//   final Address? billingAddress;
//   final Region? region;
//   final SalesChannel? salesChannel;
//   final Address? shippingAddress;
//   final List<Discount>? discounts;
//   final List<LineItem>? items; // Changed from List<ProductModel>
//   final List<ShippingMethod>? shippingMethods;
//   final List<GiftCard>? giftCards;
//
//   Cart({
//     required this.id,
//     this.email, // Made email nullable in constructor to match field
//     this.billingAddressId, // Made nullable to match field
//     this.shippingAddressId, // Made nullable to match field
//     required this.regionId,
//     this.customerId, // Made nullable to match field
//     this.customer,
//     this.paymentSession, // Made nullable to match field
//     this.paymentId, // Made nullable to match field
//     this.payment,
//     this.completedAt, // Made nullable to match field
//     this.paymentAuthorizedAt, // Made nullable to match field
//     this.salesChannelId,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt, // Made nullable to match field
//     this.shippingTotal,
//     this.discountTotal,
//     this.itemTaxTotal,
//     this.shippingTaxTotal,
//     this.taxTotal,
//     this.refundedTotal,
//     this.total,
//     this.subtotal,
//     this.refundableAmount,
//     this.giftCardTotal,
//     this.giftCardTaxTotal,
//     this.paymentSessions,
//     required this.type,
//     this.idempotencyKey, // Made nullable to match field
//     this.context, // Made nullable to match field
//     this.metadata, // Made nullable to match field
//     this.billingAddress,
//     this.salesChannel,
//     this.shippingAddress,
//     this.shippingMethods,
//     this.region,
//     this.giftCards,
//     this.discounts,
//     this.items,
//   });
//
//   factory Cart.fromJson(Map<String, dynamic> json) {
//     return Cart(
//       id: json['id'],
//       email: json['email'],
//       billingAddressId: json['billing_address_id'],
//       shippingAddressId: json['shipping_address_id'],
//       regionId: json['region_id'],
//       customerId: json['customer_id'],
//       customer: json['customer'] != null ? Map<String, dynamic>.from(json['customer']) : null,
//       paymentSession: json['payment_session'] != null ? PaymentSession.fromJson(json['payment_session']) : null,
//       paymentId: json['payment_id'],
//       payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
//       completedAt: json['completed_at'] != null ? DateTime.parse(json['completed_at']) : null,
//       paymentAuthorizedAt: json['payment_authorized_at'] != null ? DateTime.parse(json['payment_authorized_at']) : null,
//       salesChannelId: json['sales_channel_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       shippingTotal: json['shipping_total'],
//       discountTotal: json['discount_total'],
//       itemTaxTotal: json['item_tax_total'], // API uses item_tax_total
//       shippingTaxTotal: json['shipping_tax_total'],
//       taxTotal: json['tax_total'],
//       refundedTotal: json['refunded_total'],
//       total: json['total'],
//       subtotal: json['subtotal'],
//       refundableAmount: json['refundable_amount'],
//       giftCardTotal: json['gift_card_total'],
//       giftCardTaxTotal: json['gift_card_tax_total'],
//       paymentSessions: json['payment_sessions'] != null
//           ? List<PaymentSession>.from(json['payment_sessions'].map((x) => PaymentSession.fromJson(x)))
//           : null,
//       type: _parseCartType(json['type'] ?? 'default'),
//       idempotencyKey: json['idempotency_key'],
//       context: json['context'] != null ? Map<String, dynamic>.from(json['context']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       billingAddress: json['billing_address'] != null ? Address.fromJson(json['billing_address']) : null,
//       salesChannel: json['sales_channel'] != null ? SalesChannel.fromJson(json['sales_channel']) : null,
//       shippingAddress: json['shipping_address'] != null ? Address.fromJson(json['shipping_address']) : null,
//       shippingMethods: json['shipping_methods'] != null
//           ? List<ShippingMethod>.from(json['shipping_methods'].map((x) => ShippingMethod.fromJson(x)))
//           : null,
//       region: json['region'] != null ? Region.fromJson(json['region']) : null,
//       giftCards: json['gift_cards'] != null
//           ? List<GiftCard>.from(json['gift_cards'].map((x) => GiftCard.fromJson(x)))
//           : null,
//       discounts: json['discounts'] != null
//           ? List<Discount>.from(json['discounts'].map((x) => Discount.fromJson(x)))
//           : null,
//       items: json['items'] != null
//           ? List<LineItem>.from(json['items'].map((x) => LineItem.fromJson(x))) // Changed to LineItem
//           : null,
//     );
//   }
// }
//
// class LineItem {
//   final String id;
//   final String? cartId;
//   final String? orderId;
//   final String? swapId;
//   final String? claimOrderId;
//   final String? orderEditId;
//   final String title;
//   final String description;
//   final String? thumbnail;
//   final bool isGiftcard;
//   final bool shouldMerge;
//   final bool allowDiscounts;
//   final bool? hasShipping; // Sample shows <boolean>
//   final int unitPrice;
//   final int quantity;
//   final int? fulfilledQuantity;
//   final int? returnedQuantity;
//   final int? shippedQuantity;
//   final int? refundable;
//   final int? subtotal;
//   final int? total;
//   final int? originalTotal;
//   final int? taxTotal;
//   final int? originalTaxTotal;
//   final int? discountTotal;
//   final int? giftCardTotal;
//   final bool? includesTax; // From sample items[0].includes_tax
//   final String? originalItemId;
//   final String? variantId;
//   final ProductVariant? variant; // Assuming ProductVariant model is suitable
//   final List<TaxLine>? taxLines;
//   final List<Adjustment>? adjustments;
//   final Map<String, dynamic>? metadata;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   // Fields like 'order', 'swap', 'claim_order', 'cart', 'order_edit' from sample are omitted
//   // to avoid circular dependencies, relying on their respective IDs.
//
//   LineItem({
//     required this.id,
//     this.cartId,
//     this.orderId,
//     this.swapId,
//     this.claimOrderId,
//     this.orderEditId,
//     required this.title,
//     required this.description,
//     this.thumbnail,
//     required this.isGiftcard,
//     required this.shouldMerge,
//     required this.allowDiscounts,
//     this.hasShipping,
//     required this.unitPrice,
//     required this.quantity,
//     this.fulfilledQuantity,
//     this.returnedQuantity,
//     this.shippedQuantity,
//     this.refundable,
//     this.subtotal,
//     this.total,
//     this.originalTotal,
//     this.taxTotal,
//     this.originalTaxTotal,
//     this.discountTotal,
//     this.giftCardTotal,
//     this.includesTax,
//     this.originalItemId,
//     this.variantId,
//     this.variant,
//     this.taxLines,
//     this.adjustments,
//     this.metadata,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory LineItem.fromJson(Map<String, dynamic> json) {
//     return LineItem(
//       id: json['id'],
//       cartId: json['cart_id'],
//       orderId: json['order_id'],
//       swapId: json['swap_id'],
//       claimOrderId: json['claim_order_id'],
//       orderEditId: json['order_edit_id'],
//       title: json['title'],
//       description: json['description'],
//       thumbnail: json['thumbnail'],
//       isGiftcard: json['is_giftcard'] ?? false,
//       shouldMerge: json['should_merge'] ?? true, // Default based on common usage
//       allowDiscounts: json['allow_discounts'] ?? true, // Default based on common usage
//       hasShipping: json['has_shipping'],
//       unitPrice: json['unit_price'],
//       quantity: json['quantity'],
//       fulfilledQuantity: json['fulfilled_quantity'],
//       returnedQuantity: json['returned_quantity'],
//       shippedQuantity: json['shipped_quantity'],
//       refundable: json['refundable'],
//       subtotal: json['subtotal'],
//       total: json['total'],
//       originalTotal: json['original_total'],
//       taxTotal: json['tax_total'],
//       originalTaxTotal: json['original_tax_total'],
//       discountTotal: json['discount_total'],
//       giftCardTotal: json['gift_card_total'],
//       includesTax: json['includes_tax'],
//       originalItemId: json['original_item_id'],
//       variantId: json['variant_id'],
//       variant: json['variant'] != null ? ProductVariant.fromJson(json['variant']) : null,
//       taxLines: json['tax_lines'] != null
//           ? List<TaxLine>.from(json['tax_lines'].map((x) => TaxLine.fromJson(x)))
//           : null,
//       adjustments: json['adjustments'] != null
//           ? List<Adjustment>.from(json['adjustments'].map((x) => Adjustment.fromJson(x)))
//           : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }
//
// class Adjustment {
//   final String id;
//   final String? itemId;
//   final String description;
//   final int amount;
//   final String? discountId;
//   final Discount? discount; // If the API expands the discount object
//   final Map<String, dynamic>? metadata;
//
//   Adjustment({
//     required this.id,
//     this.itemId,
//     required this.description,
//     required this.amount,
//     this.discountId,
//     this.discount,
//     this.metadata,
//   });
//
//   factory Adjustment.fromJson(Map<String, dynamic> json) {
//     return Adjustment(
//       id: json['id'],
//       itemId: json['item_id'],
//       description: json['description'],
//       amount: json['amount'],
//       discountId: json['discount_id'],
//       discount: json['discount'] != null ? Discount.fromJson(json['discount']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//     );
//   }
// }
//
// enum CartType {
//   default_,
//   swap,
//   draftOrder,
//   paymentLink,
//   claim
// }
//
// CartType _parseCartType(String type) {
//   switch (type) {
//     case 'default': return CartType.default_;
//     case 'swap': return CartType.swap;
//     case 'draft_order': return CartType.draftOrder;
//     case 'payment_link': return CartType.paymentLink;
//     case 'claim': return CartType.claim;
//     default: print('Unknown CartType: $type, defaulting to default_'); return CartType.default_;
//   }
// }
//
// class Address {
//   final String id;
//   final String? customerId;
//   final String? company;
//   final String? firstName; // Made nullable based on common API patterns, verify if truly required
//   final String? lastName;  // Made nullable, verify
//   final String? address1;  // Made nullable, verify
//   final String? address2;
//   final String? city;      // Made nullable, verify
//   final String? countryCode;
//   final String? province;
//   final String? postalCode; // Made nullable, verify
//   final String? phone;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final Map<String, dynamic>? metadata;
//   final Country? country;
//
//   Address({
//     required this.id,
//     this.customerId,
//     this.company,
//     this.firstName,
//     this.lastName,
//     this.address1,
//     this.address2,
//     this.city,
//     this.countryCode,
//     this.province,
//     this.postalCode,
//     this.phone,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     this.metadata,
//     this.country,
//   });
//
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       id: json['id'],
//       customerId: json['customer_id'],
//       company: json['company'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       address1: json['address_1'],
//       address2: json['address_2'],
//       city: json['city'],
//       countryCode: json['country_code'],
//       province: json['province'],
//       postalCode: json['postal_code'],
//       phone: json['phone'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       country: json['country'] != null ? Country.fromJson(json['country']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'customer_id': customerId,
//       'company': company,
//       'first_name': firstName,
//       'last_name': lastName,
//       'address_1': address1,
//       'address_2': address2,
//       'city': city,
//       'country_code': countryCode,
//       'province': province,
//       'postal_code': postalCode,
//       'phone': phone,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'deleted_at': deletedAt?.toIso8601String(),
//       'metadata': metadata,
//       'country': country?.toJson(),
//     };
//   }
//
//   String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
//
//   String get formattedAddress {
//     final List<String?> parts = [
//       address1,
//       address2,
//       if (city != null || province != null || postalCode != null)
//         '${city ?? ''}, ${province ?? ''} ${postalCode ?? ''}'.trim().replaceAll(RegExp(r'^,|, $'),'').replaceAll(RegExp(r'\s+,|,\s+'),', '), // Defensive trimming
//       country?.name ?? countryCode,
//     ];
//     return parts.where((part) => part != null && part.isNotEmpty).join(', ');
//   }
//
//   Address copyWith({
//     String? id,
//     String? customerId,
//     String? company,
//     String? firstName,
//     String? lastName,
//     String? address1,
//     String? address2,
//     String? city,
//     String? countryCode,
//     String? province,
//     String? postalCode,
//     String? phone,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     DateTime? deletedAt,
//     Map<String, dynamic>? metadata,
//     Country? country,
//   }) {
//     return Address(
//       id: id ?? this.id,
//       customerId: customerId ?? this.customerId,
//       company: company ?? this.company,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       address1: address1 ?? this.address1,
//       address2: address2 ?? this.address2,
//       city: city ?? this.city,
//       countryCode: countryCode ?? this.countryCode,
//       province: province ?? this.province,
//       postalCode: postalCode ?? this.postalCode,
//       phone: phone ?? this.phone,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       deletedAt: deletedAt ?? this.deletedAt,
//       metadata: metadata ?? this.metadata,
//       country: country ?? this.country,
//     );
//   }
// }
//
// class TaxRate {
//   final String id;
//   final String? code; // Sample implies it can be string
//   final String name;
//   final double? rate; // Sample shows <number>
//   final String regionId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Map<String, dynamic>? metadata;
//   // final List<Product>? products; // Sample has products, omitted for simplicity and potential circular ref
//   // final List<ProductType>? product_types; // Sample has, omitted
//
//   TaxRate({
//     required this.id,
//     this.code,
//     required this.name,
//     this.rate,
//     required this.regionId,
//     required this.createdAt,
//     required this.updatedAt,
//     this.metadata,
//   });
//
//   factory TaxRate.fromJson(Map<String, dynamic> json) {
//     return TaxRate(
//       id: json['id'] ?? '',
//       code: json['code'],
//       name: json['name'] ?? '',
//       rate: json['rate'] != null ? double.tryParse(json['rate'].toString()) : null,
//       regionId: json['region_id'] ?? '',
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       metadata: json['metadata'] as Map<String, dynamic>?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'code': code,
//       'name': name,
//       'rate': rate,
//       'region_id': regionId,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'metadata': metadata,
//     };
//   }
// }
//
// class PaymentSession {
//   final String id;
//   final String? cartId; // Sample has cart_id
//   final String providerId;
//   final bool? isSelected; // Sample has <boolean>
//   final String status; // Sample has "authorized", "error" etc.
//   final Map<String, dynamic>? data; // Sample has {}
//   final int? amount; // Sample has <integer>
//   final String? idempotencyKey;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt; // Not in sample's payment_session but good to keep if API might send
//   final bool? isInitiated; // Sample has false
//   final DateTime? paymentAuthorizedAt;
//
//   PaymentSession({
//     required this.id,
//     this.cartId,
//     required this.providerId,
//     this.isSelected,
//     required this.status,
//     this.data,
//     this.amount,
//     this.idempotencyKey,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     this.isInitiated,
//     this.paymentAuthorizedAt,
//   });
//
//   factory PaymentSession.fromJson(Map<String, dynamic> json) {
//     return PaymentSession(
//       id: json['id'],
//       cartId: json['cart_id'],
//       providerId: json['provider_id'],
//       isSelected: json['is_selected'],
//       status: json['status'],
//       data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
//       amount: json['amount'],
//       idempotencyKey: json['idempotency_key'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null, // Keep if API might send
//       isInitiated: json['is_initiated'],
//       paymentAuthorizedAt: json['payment_authorized_at'] != null ? DateTime.parse(json['payment_authorized_at']) : null,
//     );
//   }
//
//   String get providerName {
//     switch (providerId.toLowerCase()) { // Added toLowerCase for robustness
//       case 'stripe': return 'Stripe';
//       case 'paypal': return 'PayPal';
//       case 'manual': return 'Manual Payment';
//       default: return providerId;
//     }
//   }
//
//   String get displayStatus {
//     switch (status.toLowerCase()) { // Added toLowerCase
//       case 'authorized': return 'Authorized';
//       case 'pending': return 'Pending';
//       case 'requires_more': return 'Requires Additional Action';
//       case 'error': return 'Error';
//       case 'canceled': return 'Canceled';
//       default: return status;
//     }
//   }
//
//   bool get isStripe => providerId.toLowerCase() == 'stripe';
//   bool get isPayPal => providerId.toLowerCase() == 'paypal';
//   String? get stripeClientSecret => isStripe ? (data?['client_secret'] as String?) : null;
//
//
//   PaymentSession copyWith({
//     String? id, String? cartId, String? providerId, bool? isSelected, String? status,
//     Map<String, dynamic>? data, int? amount, String? idempotencyKey, DateTime? createdAt,
//     DateTime? updatedAt, DateTime? deletedAt, bool? isInitiated, DateTime? paymentAuthorizedAt,
//   }) {
//     return PaymentSession(
//       id: id ?? this.id, cartId: cartId ?? this.cartId, providerId: providerId ?? this.providerId,
//       isSelected: isSelected ?? this.isSelected, status: status ?? this.status,
//       data: data ?? this.data, amount: amount ?? this.amount,
//       idempotencyKey: idempotencyKey ?? this.idempotencyKey, createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt, deletedAt: deletedAt ?? this.deletedAt,
//       isInitiated: isInitiated ?? this.isInitiated, paymentAuthorizedAt: paymentAuthorizedAt ?? this.paymentAuthorizedAt,
//     );
//   }
// }
//
// class Payment {
//   final String id; // From sample
//   final int amount;
//   final int amountRefunded; // Sample has 0
//   final DateTime? canceledAt;
//   final DateTime? capturedAt;
//   final String? cartId;
//   final DateTime createdAt;
//   final String currencyCode;
//   final Map<String, dynamic>? data;
//   final String? idempotencyKey;
//   final Map<String, dynamic>? metadata;
//   final String? orderId;
//   final String providerId;
//   final String? swapId;
//   final DateTime updatedAt;
//   final Currency? currency; // Sample has nested currency
//
//   Payment({
//     required this.id,
//     required this.amount,
//     required this.amountRefunded,
//     this.canceledAt,
//     this.capturedAt,
//     this.cartId,
//     required this.createdAt,
//     required this.currencyCode,
//     this.data,
//     this.idempotencyKey,
//     this.metadata,
//     this.orderId,
//     required this.providerId,
//     this.swapId,
//     required this.updatedAt,
//     this.currency, // Changed from required Currency to Currency? to match fromJson
//   });
//
//   factory Payment.fromJson(Map<String, dynamic> json) {
//     return Payment(
//       id: json['id'],
//       amount: json['amount'],
//       amountRefunded: json['amount_refunded'],
//       canceledAt: json['canceled_at'] != null ? DateTime.parse(json['canceled_at']) : null,
//       capturedAt: json['captured_at'] != null ? DateTime.parse(json['captured_at']) : null,
//       cartId: json['cart_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       currencyCode: json['currency_code'],
//       data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
//       idempotencyKey: json['idempotency_key'],
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       orderId: json['order_id'],
//       providerId: json['provider_id'],
//       swapId: json['swap_id'],
//       updatedAt: DateTime.parse(json['updated_at']),
//       currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
//     );
//   }
// }
//
// class SalesChannel {
//   final String id;
//   final String name;
//   final String? description; // Sample has string
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final DateTime? deletedAt;
//   final bool? isDisabled; // Sample has false
//   final List<Location>? locations; // Sample has locations array
//
//   SalesChannel({
//     required this.id,
//     required this.name,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.isDisabled,
//     this.locations, // Original was required
//   });
//
//   factory SalesChannel.fromJson(Map<String, dynamic> json) {
//     return SalesChannel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'],
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       isDisabled: json['is_disabled'],
//       locations: (json['locations'] as List<dynamic>?)
//           ?.map((e) => Location.fromJson(e as Map<String,dynamic>)) // Added type cast
//           .toList(),
//     );
//   }
// }
//
// class Location {
//   final String id;
//   final String locationId; // Sample has location_id
//   final String salesChannelId; // Sample has sales_channel_id
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final DateTime? deletedAt;
//
//   Location({
//     required this.id,
//     required this.locationId,
//     required this.salesChannelId,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       id: json['id'] ?? '',
//       locationId: json['location_id'] ?? '',
//       salesChannelId: json['sales_channel_id'] ?? '',
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//     );
//   }
// }
//
// class Discount {
//   final String id;
//   final String code;
//   final bool isDynamic;
//   final bool isDisabled; // Sample shows <boolean>
//   final String? ruleId;
//   final String? parentDiscountId;
//   final DateTime? startsAt;
//   final DateTime? endsAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final Map<String, dynamic>? metadata;
//   final int? usageLimit; // Sample shows <integer>
//   final int usageCount; // Sample shows 0
//   final String? validDuration;
//   final DiscountRule? rule;
//   final Discount? parentDiscount; // Sample has parent_discount with circular ref
//   final List<Region>? regions;
//
//   Discount({
//     required this.id,
//     required this.code,
//     required this.isDynamic,
//     required this.isDisabled,
//     this.ruleId,
//     this.parentDiscountId,
//     this.startsAt,
//     this.endsAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//     this.metadata,
//     this.usageLimit,
//     required this.usageCount,
//     this.validDuration,
//     this.rule,
//     this.parentDiscount,
//     this.regions,
//   });
//
//   factory Discount.fromJson(Map<String, dynamic> json) {
//     List<Region>? regionsList;
//     if (json['regions'] != null && json['regions'] is List) {
//       regionsList = (json['regions'] as List)
//           .where((region) => region is Map<String, dynamic> && !(region['value']?.toString().contains('Circular reference') ?? false))
//           .map((region) => Region.fromJson(region))
//           .toList();
//     }
//
//     Discount? parentDiscountData;
//     if (json['parent_discount'] != null && json['parent_discount'] is Map<String, dynamic> && !(json['parent_discount']['value']?.toString().contains('Circular reference') ?? false)) {
//       // parentDiscountData = Discount.fromJson(json['parent_discount']); // Avoid direct recursion if it's indeed the same type
//     }
//
//
//     return Discount(
//       id: json['id'] ?? '',
//       code: json['code'] ?? '',
//       isDynamic: _parseBooleanValue(json['is_dynamic']),
//       isDisabled: _parseBooleanValue(json['is_disabled']),
//       ruleId: json['rule_id'],
//       parentDiscountId: json['parent_discount_id'],
//       startsAt: json['starts_at'] != null ? DateTime.parse(json['starts_at']) : null,
//       endsAt: json['ends_at'] != null ? DateTime.parse(json['ends_at']) : null,
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       usageLimit: json['usage_limit'] != null ? int.tryParse(json['usage_limit'].toString()) : null,
//       usageCount: json['usage_count'] != null ? int.tryParse(json['usage_count'].toString()) ?? 0 : 0,
//       validDuration: json['valid_duration'],
//       rule: json['rule'] != null ? DiscountRule.fromJson(json['rule']) : null,
//       parentDiscount: parentDiscountData, // Assign parsed parent if available
//       regions: regionsList,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'code': code, 'is_dynamic': isDynamic, 'is_disabled': isDisabled, 'rule_id': ruleId,
//       'parent_discount_id': parentDiscountId, 'starts_at': startsAt?.toIso8601String(),
//       'ends_at': endsAt?.toIso8601String(), 'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(), 'deleted_at': deletedAt?.toIso8601String(),
//       'metadata': metadata, 'usage_limit': usageLimit, 'usage_count': usageCount,
//       'valid_duration': validDuration, 'rule': rule?.toJson(),
//       // 'parent_discount': parentDiscount?.toJson(), // Careful with circular to JSON
//       'regions': regions?.map((region) => region.toJson()).toList(),
//     };
//   }
//   bool get isExpired => endsAt != null && endsAt!.isBefore(DateTime.now());
//   bool get isActive {
//     final now = DateTime.now();
//     bool hasStarted = startsAt == null || startsAt!.isBefore(now);
//     bool hasNotEnded = endsAt == null || endsAt!.isAfter(now);
//     return hasStarted && hasNotEnded && !isDisabled;
//   }
//   bool get isUsageLimitReached => usageLimit != null && usageCount >= usageLimit!;
//   String get formattedValue {
//     if (rule == null) return '';
//     if (rule!.type == DiscountRuleType.percentage) return '${rule!.value}%';
//     else if (rule!.type == DiscountRuleType.fixed) {
//       if (regions != null && regions!.isNotEmpty) {
//         final currencyCode = regions!.first.currencyCode;
//         return '${_getCurrencySymbol(currencyCode)} ${rule!.value / 100}';
//       }
//       return '${rule!.value / 100}';
//     } else return 'Free shipping';
//   }
//   String get displayText {
//     final discountType = rule?.type ?? DiscountRuleType.fixed;
//     final value = formattedValue;
//     switch (discountType) {
//       case DiscountRuleType.fixed: return '$value off';
//       case DiscountRuleType.percentage: return '$value off';
//       case DiscountRuleType.freeShipping: return 'Free shipping';
//       }
//   }
//   String get timeRemainingText {
//     if (endsAt == null) return 'No expiration';
//     final now = DateTime.now();
//     final difference = endsAt!.difference(now);
//     if (difference.isNegative) return 'Expired';
//     final days = difference.inDays;
//     final hours = difference.inHours % 24;
//     if (days > 0) return '$days ${days == 1 ? 'day' : 'days'} remaining';
//     else if (hours > 0) return '$hours ${hours == 1 ? 'hour' : 'hours'} remaining';
//     else {
//       final minutes = difference.inMinutes % 60;
//       return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} remaining';
//     }
//   }
//   Discount copyWith({
//     String? id, String? code, bool? isDynamic, bool? isDisabled, String? ruleId, String? parentDiscountId,
//     DateTime? startsAt, DateTime? endsAt, DateTime? createdAt, DateTime? updatedAt, DateTime? deletedAt,
//     Map<String, dynamic>? metadata, int? usageLimit, int? usageCount, String? validDuration,
//     DiscountRule? rule, Discount? parentDiscount, List<Region>? regions,
//   }) {
//     return Discount(
//       id: id ?? this.id, code: code ?? this.code, isDynamic: isDynamic ?? this.isDynamic,
//       isDisabled: isDisabled ?? this.isDisabled, ruleId: ruleId ?? this.ruleId,
//       parentDiscountId: parentDiscountId ?? this.parentDiscountId, startsAt: startsAt ?? this.startsAt,
//       endsAt: endsAt ?? this.endsAt, createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt,
//       deletedAt: deletedAt ?? this.deletedAt, metadata: metadata ?? this.metadata,
//       usageLimit: usageLimit ?? this.usageLimit, usageCount: usageCount ?? this.usageCount,
//       validDuration: validDuration ?? this.validDuration, rule: rule ?? this.rule,
//       parentDiscount: parentDiscount ?? this.parentDiscount, regions: regions ?? this.regions,
//     );
//   }
//   String _getCurrencySymbol(String currencyCode) {
//     switch (currencyCode.toUpperCase()) {
//       case 'USD': return '\$'; case 'EUR': return '€'; case 'GBP': return '£'; case 'JPY': return '¥';
//       case 'CAD': return 'C\$'; case 'AUD': return 'A\$'; case 'INR': return '₹'; case 'BRL': return 'R\$';
//       default: return currencyCode;
//     }
//   }
//   static bool _parseBooleanValue(dynamic value) {
//     if (value is bool) return value;
//     if (value is String) return value.toLowerCase() == 'true' || value == '1';
//     if (value is num) return value != 0;
//     return false;
//   }
// }
//
// enum DiscountRuleType { fixed, percentage, freeShipping }
// DiscountRuleType _parseDiscountRuleType(String? type) {
//   if (type == null) return DiscountRuleType.fixed;
//   switch (type.toLowerCase()) {
//     case 'percentage': return DiscountRuleType.percentage;
//     case 'free_shipping': return DiscountRuleType.freeShipping;
//     case 'fixed': default: return DiscountRuleType.fixed;
//   }
// }
// String _discountRuleTypeToString(DiscountRuleType type) {
//   switch (type) {
//     case DiscountRuleType.percentage: return 'percentage';
//     case DiscountRuleType.freeShipping: return 'free_shipping';
//     case DiscountRuleType.fixed: return 'fixed';
//   }
// }
// enum DiscountAllocation { total, item }
// DiscountAllocation _parseDiscountAllocation(String? allocation) {
//   if (allocation == null) return DiscountAllocation.total; // Sample has "total", "item"
//   switch (allocation.toLowerCase()) {
//     case 'item': return DiscountAllocation.item;
//     case 'total': default: return DiscountAllocation.total;
//   }
// }
// String _discountAllocationToString(DiscountAllocation allocation) {
//   switch (allocation) {
//     case DiscountAllocation.item: return 'item';
//     case DiscountAllocation.total: return 'total';
//   }
// }
//
// class DiscountRule {
//   final String id;
//   final DiscountRuleType type; // Sample has "fixed", "percentage" etc.
//   final String? description;
//   final int value; // Sample has <integer>
//   final DiscountAllocation allocation; // Sample has "total", "item"
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final Map<String, dynamic>? metadata;
//   final List<DiscountCondition>? conditions;
//
//   DiscountRule({
//     required this.id, required this.type, this.description, required this.value,
//     required this.allocation, required this.createdAt, required this.updatedAt,
//     this.deletedAt, this.metadata, this.conditions,
//   });
//
//   factory DiscountRule.fromJson(Map<String, dynamic> json) {
//     List<DiscountCondition>? conditionsList;
//     if (json['conditions'] != null && json['conditions'] is List) {
//       conditionsList = (json['conditions'] as List).map((condition) => DiscountCondition.fromJson(condition)).toList();
//     }
//     return DiscountRule(
//       id: json['id'] ?? '', type: _parseDiscountRuleType(json['type']),
//       description: json['description'],
//       value: json['value'] != null ? int.tryParse(json['value'].toString()) ?? 0 : 0,
//       allocation: _parseDiscountAllocation(json['allocation']),
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       conditions: conditionsList,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'type': _discountRuleTypeToString(type), 'description': description,
//       'value': value, 'allocation': _discountAllocationToString(allocation),
//       'created_at': createdAt.toIso8601String(), 'updated_at': updatedAt.toIso8601String(),
//       'deleted_at': deletedAt?.toIso8601String(), 'metadata': metadata,
//       'conditions': conditions?.map((condition) => condition.toJson()).toList(),
//     };
//   }
//   String get typeLabel {
//     switch (type) {
//       case DiscountRuleType.percentage: return 'Percentage';
//       case DiscountRuleType.fixed: return 'Fixed Amount';
//       case DiscountRuleType.freeShipping: return 'Free Shipping';
//     }
//   }
//   String get formattedValue {
//     switch (type) {
//       case DiscountRuleType.percentage: return '$value%';
//       case DiscountRuleType.fixed: return '${value / 100}'; // Assuming value is in cents
//       case DiscountRuleType.freeShipping: return 'Free Shipping';
//     }
//   }
//   bool get appliesToEntireCart => allocation == DiscountAllocation.total;
//   DiscountRule copyWith({
//     String? id, DiscountRuleType? type, String? description, int? value, DiscountAllocation? allocation,
//     DateTime? createdAt, DateTime? updatedAt, DateTime? deletedAt, Map<String, dynamic>? metadata,
//     List<DiscountCondition>? conditions,
//   }) {
//     return DiscountRule(
//       id: id ?? this.id, type: type ?? this.type, description: description ?? this.description,
//       value: value ?? this.value, allocation: allocation ?? this.allocation,
//       createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt,
//       deletedAt: deletedAt ?? this.deletedAt, metadata: metadata ?? this.metadata,
//       conditions: conditions ?? this.conditions,
//     );
//   }
// }
//
// enum DiscountConditionType { products, productTypes, productCollections, productTags, customerGroups }
// DiscountConditionType _parseDiscountConditionType(String? type) {
//   if (type == null) return DiscountConditionType.products;
//   switch (type.toLowerCase()) { // Sample types: customer_groups, product_tags etc.
//     case 'product_types': return DiscountConditionType.productTypes;
//     case 'product_collections': return DiscountConditionType.productCollections;
//     case 'product_tags': return DiscountConditionType.productTags;
//     case 'customer_groups': return DiscountConditionType.customerGroups;
//     case 'products': default: return DiscountConditionType.products;
//   }
// }
// String _discountConditionTypeToString(DiscountConditionType type) {
//   switch (type) {
//     case DiscountConditionType.productTypes: return 'product_types';
//     case DiscountConditionType.productCollections: return 'product_collections';
//     case DiscountConditionType.productTags: return 'product_tags';
//     case DiscountConditionType.customerGroups: return 'customer_groups';
//     case DiscountConditionType.products: return 'products';
//   }
// }
// enum DiscountConditionOperator { inn, notIn } // API sample uses "in", "not_in"
// DiscountConditionOperator _parseDiscountConditionOperator(String? operator) {
//   if (operator == null) return DiscountConditionOperator.inn;
//   switch (operator.toLowerCase()) {
//     case 'not_in': return DiscountConditionOperator.notIn;
//     case 'in': default: return DiscountConditionOperator.inn;
//   }
// }
// String _discountConditionOperatorToString(DiscountConditionOperator operator) {
//   switch (operator) {
//     case DiscountConditionOperator.notIn: return 'not_in';
//     case DiscountConditionOperator.inn: return 'in';
//   }
// }
//
// class DiscountCondition {
//   final String id;
//   final String discountRuleId;
//   final DiscountConditionType type;
//   final DiscountConditionOperator operator;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final Map<String, dynamic>? metadata;
//   final List<Map<String, dynamic>>? products; // Simplified as in original
//   final List<Map<String, dynamic>>? productTypes;
//   final List<Map<String, dynamic>>? productTags;
//   final List<Map<String, dynamic>>? productCollections;
//   final List<Map<String, dynamic>>? customerGroups;
//
//   DiscountCondition({
//     required this.id, required this.discountRuleId, required this.type, required this.operator,
//     required this.createdAt, required this.updatedAt, this.deletedAt, this.metadata,
//     this.products, this.productTypes, this.productTags, this.productCollections, this.customerGroups,
//   });
//
//   factory DiscountCondition.fromJson(Map<String, dynamic> json) {
//     List<Map<String, dynamic>>? extractEntities(List? entitiesList) {
//       if (entitiesList == null) return null;
//       return entitiesList.where((entity) => entity is Map<String, dynamic>).map((entity) {
//         return { 'id': entity['id'] ?? '', 'title': entity['title'] ?? entity['name'] ?? entity['value'] ?? '',
//           'created_at': entity['created_at'], 'updated_at': entity['updated_at'], };
//       }).toList();
//     }
//     return DiscountCondition(
//       id: json['id'] ?? '', discountRuleId: json['discount_rule_id'] ?? '',
//       type: _parseDiscountConditionType(json['type']),
//       operator: _parseDiscountConditionOperator(json['operator']),
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       products: extractEntities(json['products']), productTypes: extractEntities(json['product_types']),
//       productTags: extractEntities(json['product_tags']), productCollections: extractEntities(json['product_collections']),
//       customerGroups: extractEntities(json['customer_groups']),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'discount_rule_id': discountRuleId, 'type': _discountConditionTypeToString(type),
//       'operator': _discountConditionOperatorToString(operator), 'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(), 'deleted_at': deletedAt?.toIso8601String(),
//       'metadata': metadata, 'products': products, 'product_types': productTypes,
//       'product_tags': productTags, 'product_collections': productCollections, 'customer_groups': customerGroups,
//     };
//   }
//   String get description {
//     final String entityType; final int entityCount;
//     switch (type) {
//       case DiscountConditionType.products: entityType = 'products'; entityCount = products?.length ?? 0; break;
//       case DiscountConditionType.productTypes: entityType = 'product types'; entityCount = productTypes?.length ?? 0; break;
//       case DiscountConditionType.productTags: entityType = 'product tags'; entityCount = productTags?.length ?? 0; break;
//       case DiscountConditionType.productCollections: entityType = 'collections'; entityCount = productCollections?.length ?? 0; break;
//       case DiscountConditionType.customerGroups: entityType = 'customer groups'; entityCount = customerGroups?.length ?? 0; break;
//     }
//     final String operatorText = operator == DiscountConditionOperator.inn ? 'Applies to' : 'Does not apply to';
//     return '$operatorText $entityCount $entityType';
//   }
//   DiscountCondition copyWith({
//     String? id, String? discountRuleId, DiscountConditionType? type, DiscountConditionOperator? operator,
//     DateTime? createdAt, DateTime? updatedAt, DateTime? deletedAt, Map<String, dynamic>? metadata,
//     List<Map<String, dynamic>>? products, List<Map<String, dynamic>>? productTypes,
//     List<Map<String, dynamic>>? productTags, List<Map<String, dynamic>>? productCollections,
//     List<Map<String, dynamic>>? customerGroups,
//   }) {
//     return DiscountCondition(
//       id: id ?? this.id, discountRuleId: discountRuleId ?? this.discountRuleId, type: type ?? this.type,
//       operator: operator ?? this.operator, createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt,
//       deletedAt: deletedAt ?? this.deletedAt, metadata: metadata ?? this.metadata, products: products ?? this.products,
//       productTypes: productTypes ?? this.productTypes, productTags: productTags ?? this.productTags,
//       productCollections: productCollections ?? this.productCollections, customerGroups: customerGroups ?? this.customerGroups,
//     );
//   }
// }
//
// class ShippingMethod {
//   final String id;
//   final String shippingOptionId;
//   final String? cartId;
//   final String? orderId;
//   final String? claimOrderId;
//   final String? swapId;
//   final String? returnId;
//   final int price; // Sample has <integer>
//   final Map<String, dynamic>? data;
//   final bool? includesTax; // Sample has boolean
//   final int? subtotal; // Sample has <integer>
//   final int? total; // Sample has <integer>
//   final int? taxTotal; // Sample has <integer>
//   final ShippingOption? shippingOption;
//   final List<TaxLine>? taxLines;
//
//   ShippingMethod({
//     required this.id, required this.shippingOptionId, this.cartId, this.orderId,
//     this.claimOrderId, this.swapId, this.returnId, required this.price, this.data,
//     this.includesTax, this.subtotal, this.total, this.taxTotal,
//     this.shippingOption, this.taxLines,
//   });
//
//   factory ShippingMethod.fromJson(Map<String, dynamic> json) {
//     List<TaxLine>? taxLinesList;
//     if (json['tax_lines'] != null && json['tax_lines'] is List) {
//       taxLinesList = (json['tax_lines'] as List).map((taxLine) => TaxLine.fromJson(taxLine)).toList();
//     }
//     ShippingOption? shippingOptionData;
//     if (json['shipping_option'] != null && json['shipping_option'] is Map<String, dynamic> && !(json['shipping_option']['value']?.toString().contains('Circular reference') ?? false)) {
//       shippingOptionData = ShippingOption.fromJson(json['shipping_option']);
//     }
//     return ShippingMethod(
//       id: json['id'] ?? '', shippingOptionId: json['shipping_option_id'] ?? '',
//       cartId: json['cart_id'], orderId: json['order_id'], claimOrderId: json['claim_order_id'],
//       swapId: json['swap_id'], returnId: json['return_id'],
//       price: json['price'] != null ? int.tryParse(json['price'].toString()) ?? 0 : 0,
//       data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
//       includesTax: json['includes_tax'],
//       subtotal: json['subtotal'] != null ? int.tryParse(json['subtotal'].toString()) : null,
//       total: json['total'] != null ? int.tryParse(json['total'].toString()) : null,
//       taxTotal: json['tax_total'] != null ? int.tryParse(json['tax_total'].toString()) : null,
//       shippingOption: shippingOptionData, taxLines: taxLinesList,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'shipping_option_id': shippingOptionId, 'cart_id': cartId, 'order_id': orderId,
//       'claim_order_id': claimOrderId, 'swap_id': swapId, 'return_id': returnId, 'price': price,
//       'data': data, 'includes_tax': includesTax, 'subtotal': subtotal, 'total': total, 'tax_total': taxTotal,
//       'shipping_option': shippingOption?.toJson(),
//       'tax_lines': taxLines?.map((taxLine) => taxLine.toJson()).toList(),
//     };
//   }
//   String formattedPrice(String currencyCode) { final symbol = _getCurrencySymbol(currencyCode); return '$symbol${(price / 100).toStringAsFixed(2)}'; }
//   String formattedTotal(String currencyCode) { if (total == null) return formattedPrice(currencyCode); final symbol = _getCurrencySymbol(currencyCode); return '$symbol${(total! / 100).toStringAsFixed(2)}'; }
//   String get name => shippingOption?.name ?? 'Shipping';
//   // deliveryEstimate, providerName etc. can be kept as they are if ShippingOption structure is consistent.
//   String _getCurrencySymbol(String currencyCode) { /* ... same as before ... */ return currencyCode;}
//
//   ShippingMethod copyWith({
//     String? id, String? shippingOptionId, String? cartId, String? orderId, String? claimOrderId, String? swapId,
//     String? returnId, int? price, Map<String, dynamic>? data, bool? includesTax, int? subtotal, int? total,
//     int? taxTotal, ShippingOption? shippingOption, List<TaxLine>? taxLines,
//   }) {
//     return ShippingMethod(
//       id: id ?? this.id, shippingOptionId: shippingOptionId ?? this.shippingOptionId, cartId: cartId ?? this.cartId,
//       orderId: orderId ?? this.orderId, claimOrderId: claimOrderId ?? this.claimOrderId, swapId: swapId ?? this.swapId,
//       returnId: returnId ?? this.returnId, price: price ?? this.price, data: data ?? this.data,
//       includesTax: includesTax ?? this.includesTax, subtotal: subtotal ?? this.subtotal, total: total ?? this.total,
//       taxTotal: taxTotal ?? this.taxTotal, shippingOption: shippingOption ?? this.shippingOption,
//       taxLines: taxLines ?? this.taxLines,
//     );
//   }
// }
//
//
// enum ShippingOptionPriceType { flatRate, calculated }
// ShippingOptionPriceType _parseShippingOptionPriceType(String? type) { // Sample has "flat_rate", "calculated"
//   if (type == null) return ShippingOptionPriceType.flatRate;
//   switch (type.toLowerCase()) {
//     case 'calculated': return ShippingOptionPriceType.calculated;
//     case 'flat_rate': default: return ShippingOptionPriceType.flatRate;
//   }
// }
// String _shippingOptionPriceTypeToString(ShippingOptionPriceType type) {
//   switch (type) {
//     case ShippingOptionPriceType.calculated: return 'calculated';
//     case ShippingOptionPriceType.flatRate: return 'flat_rate';
//   }
// }
// enum ShippingRequirementType { minSubtotal, maxSubtotal }
// ShippingRequirementType _parseShippingRequirementType(String? type) { // Sample has "min_subtotal", "max_subtotal"
//   if (type == null) return ShippingRequirementType.minSubtotal;
//   switch (type.toLowerCase()) {
//     case 'max_subtotal': return ShippingRequirementType.maxSubtotal;
//     case 'min_subtotal': default: return ShippingRequirementType.minSubtotal;
//   }
// }
// String _shippingRequirementTypeToString(ShippingRequirementType type) {
//   switch (type) {
//     case ShippingRequirementType.maxSubtotal: return 'max_subtotal';
//     case ShippingRequirementType.minSubtotal: return 'min_subtotal';
//   }
// }
//
// class ShippingRequirement {
//   final String id;
//   final String shippingOptionId;
//   final ShippingRequirementType type;
//   final int amount; // Sample has <integer>
//   final DateTime? deletedAt;
//
//   ShippingRequirement({ required this.id, required this.shippingOptionId, required this.type, required this.amount, this.deletedAt });
//   factory ShippingRequirement.fromJson(Map<String, dynamic> json) {
//     return ShippingRequirement(
//       id: json['id'] ?? '', shippingOptionId: json['shipping_option_id'] ?? '',
//       type: _parseShippingRequirementType(json['type']),
//       amount: json['amount'] != null ? int.tryParse(json['amount'].toString()) ?? 0 : 0,
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return { 'id': id, 'shipping_option_id': shippingOptionId, 'type': _shippingRequirementTypeToString(type), 'amount': amount, 'deleted_at': deletedAt?.toIso8601String() };
//   }
// // Helper methods can be kept
// }
//
// class ShippingOption {
//   final String id;
//   final String name;
//   final int? amount; // Sample has <integer>, can be optional if price_type is 'calculated'
//   final ShippingOptionPriceType priceType;
//   final String providerId;
//   final String regionId;
//   final String? profileId;
//   final bool adminOnly; // Sample has boolean
//   final bool isReturn; // Sample has boolean
//   final Map<String, dynamic>? data;
//   final Map<String, dynamic>? metadata;
//   final bool? includesTax; // Sample has boolean
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final Provider? provider;
//   final List<ShippingRequirement>? requirements;
//
//   ShippingOption({
//     required this.id, required this.name, this.amount, required this.priceType, required this.providerId,
//     required this.regionId, this.profileId, required this.adminOnly, required this.isReturn,
//     this.data, this.metadata, this.includesTax, required this.createdAt, required this.updatedAt,
//     this.deletedAt, this.provider, this.requirements,
//   });
//
//   factory ShippingOption.fromJson(Map<String, dynamic> json) {
//     List<ShippingRequirement>? requirementsList;
//     if (json['requirements'] != null && json['requirements'] is List) {
//       requirementsList = (json['requirements'] as List).map((req) => ShippingRequirement.fromJson(req)).toList();
//     }
//     return ShippingOption(
//       id: json['id'] ?? '', name: json['name'] ?? '',
//       amount: json['amount'] != null ? int.tryParse(json['amount'].toString()) : null,
//       priceType: _parseShippingOptionPriceType(json['price_type']),
//       providerId: json['provider_id'] ?? '', regionId: json['region_id'] ?? '',
//       profileId: json['profile_id'], adminOnly: _parseBooleanValue(json['admin_only']),
//       isReturn: _parseBooleanValue(json['is_return']),
//       data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       includesTax: json['includes_tax'],
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       provider: json['provider'] != null ? Provider.fromJson(json['provider']) : null,
//       requirements: requirementsList,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'name': name, 'amount': amount, 'price_type': _shippingOptionPriceTypeToString(priceType),
//       'provider_id': providerId, 'region_id': regionId, 'profile_id': profileId, 'admin_only': adminOnly,
//       'is_return': isReturn, 'data': data, 'metadata': metadata, 'includes_tax': includesTax,
//       'created_at': createdAt.toIso8601String(), 'updated_at': updatedAt.toIso8601String(),
//       'deleted_at': deletedAt?.toIso8601String(), 'provider': provider?.toJson(),
//       'requirements': requirements?.map((req) => req.toJson()).toList(),
//     };
//   }
//   // Helper methods can be kept
//   static bool _parseBooleanValue(dynamic value) {
//     if (value is bool) return value;
//     if (value is String) return value.toLowerCase() == 'true' || value == '1';
//     if (value is num) return value != 0;
//     return false;
//   }
// }
//
// class TaxLine { // Used in LineItem and ShippingMethod
//   final String id;
//   final String? code; // Sample has string
//   final String name;
//   final double rate; // Sample has <number>
//   final String? itemId; // Sample in LineItem.tax_lines has item_id
//   final String? shippingMethodId; // Sample in ShippingMethod.tax_lines has shipping_method_id
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Map<String, dynamic>? metadata;
//
//   TaxLine({
//     required this.id, this.code, required this.name, required this.rate,
//     this.itemId, this.shippingMethodId,
//     required this.createdAt, required this.updatedAt, this.metadata,
//   });
//
//   factory TaxLine.fromJson(Map<String, dynamic> json) {
//     return TaxLine(
//       id: json['id'] ?? '', code: json['code'], name: json['name'] ?? '',
//       rate: json['rate'] != null ? double.tryParse(json['rate'].toString()) ?? 0.0 : 0.0,
//       itemId: json['item_id'], shippingMethodId: json['shipping_method_id'],
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'code': code, 'name': name, 'rate': rate, 'item_id': itemId,
//       'shipping_method_id': shippingMethodId, 'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(), 'metadata': metadata,
//     };
//   }
//   String get formattedRate => '${(rate * 100).toStringAsFixed(2)}%';
//   TaxLine copyWith({
//     String? id, String? code, String? name, double? rate, String? itemId, String? shippingMethodId,
//     DateTime? createdAt, DateTime? updatedAt, Map<String, dynamic>? metadata,
//   }) {
//     return TaxLine(
//       id: id ?? this.id, code: code ?? this.code, name: name ?? this.name, rate: rate ?? this.rate,
//       itemId: itemId ?? this.itemId, shippingMethodId: shippingMethodId ?? this.shippingMethodId,
//       createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt, metadata: metadata ?? this.metadata,
//     );
//   }
// }
//
// class GiftCard {
//   final String id;
//   final String code;
//   final int value; // Sample has <integer>
//   final int balance; // Sample has <integer>
//   final String regionId;
//   final String? orderId;
//   final double? taxRate; // Sample has <number>
//   final bool isDisabled; // Sample has boolean
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? deletedAt;
//   final DateTime? endsAt;
//   final Map<String, dynamic>? metadata;
//   final Region? region;
//
//   GiftCard({
//     required this.id, required this.code, required this.value, required this.balance,
//     required this.regionId, this.orderId, this.taxRate, required this.isDisabled,
//     required this.createdAt, required this.updatedAt, this.deletedAt, this.endsAt,
//     this.metadata, this.region,
//   });
//
//   factory GiftCard.fromJson(Map<String, dynamic> json) {
//     Region? regionData;
//     if (json['region'] != null && json['region'] is Map<String, dynamic> && !(json['region']['value']?.toString().contains('Circular reference') ?? false)) {
//       regionData = Region.fromJson(json['region']);
//     }
//     return GiftCard(
//       id: json['id'] ?? '', code: json['code'] ?? '',
//       value: json['value'] != null ? int.tryParse(json['value'].toString()) ?? 0 : 0,
//       balance: json['balance'] != null ? int.tryParse(json['balance'].toString()) ?? 0 : 0,
//       regionId: json['region_id'] ?? '', orderId: json['order_id'],
//       taxRate: json['tax_rate'] != null ? double.tryParse(json['tax_rate'].toString()) : null,
//       isDisabled: _parseBooleanValue(json['is_disabled']),
//       createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
//       updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
//       deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
//       endsAt: json['ends_at'] != null ? DateTime.parse(json['ends_at']) : null,
//       metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
//       region: regionData,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id, 'code': code, 'value': value, 'balance': balance, 'region_id': regionId, 'order_id': orderId,
//       'tax_rate': taxRate, 'is_disabled': isDisabled, 'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(), 'deleted_at': deletedAt?.toIso8601String(),
//       'ends_at': endsAt?.toIso8601String(), 'metadata': metadata, 'region': region?.toJson(),
//     };
//   }
//   // Helper methods can be kept
//   static bool _parseBooleanValue(dynamic value) { /* ... same as before ... */ return false; }
// }
//
// // Your existing ProductModel and its sub-models (ProductVariant, OptionValue, ProductType, etc.)
// // would remain as they are, assuming they are used for full product definitions elsewhere.
// // The LineItem.variant field now uses ProductVariant.fromJson.
// // Ensure that the ProductVariant.fromJson in your product_model.dart
// // correctly parses the 'variant' object structure found within the API's line items.
// // Particularly, the sample shows "items[0].variant.product" as a circular reference,
// // so your ProductVariant model should ideally store productId and not a full Product object.
// // If ProductVariant already contains a Product object, this could be an issue.
//
// // Helper for parsing boolean from various formats (used in Discount, Provider, ShippingOption, GiftCard)
// bool _parseBooleanValue(dynamic value) {
//   if (value == null) return false; // Default for null
//   if (value is bool) return value;
//   if (value is String) {
//     if (value.toLowerCase() == 'true') return true;
//     if (value.toLowerCase() == 'false') return false; // Explicitly handle 'false' string
//     return value == '1';
//   }
//   if (value is num) return value != 0;
//   return false;
// }