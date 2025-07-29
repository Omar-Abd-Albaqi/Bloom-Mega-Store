import 'package:bloom/models/cart_models/address_model.dart';
import 'package:bloom/models/cart_models/place_holder_for_cart.dart';
import 'package:bloom/models/cart_models/region_model.dart';

import 'helper_functions.dart';
import 'line_item_model.dart';

class Cart {
  final String id;
  final String? currencyCode;
  final String? email;
  final String? regionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;
  final DateTime? deletedAt;
  final DateTime? paymentAuthorizedAt;

  // Totals (all nullable for flexibility)
  final int? total;
  final int? subtotal;
  final int? taxTotal;
  final int? discountTotal;
  final int? shippingTotal;

  final int? discountSubtotal;
  final int? discountTaxTotal;
  final int? originalTotal;
  final int? originalTaxTotal;
  final int? itemTotal;
  final int? itemSubtotal;
  final int? itemTaxTotal;
  final int? originalItemTotal;
  final int? originalItemSubtotal;
  final int? originalItemTaxTotal;
  final int? shippingSubtotal;
  final int? shippingTaxTotal;
  final int? originalShippingTaxTotal;
  final int? originalShippingSubtotal;
  final int? originalShippingTotal;
  final int? creditLineSubtotal;
  final int? creditLineTaxTotal;
  final int? creditLineTotal;

  // Totals from Apidog schema
  final int? rawDiscountTotal;
  final int? refundedTotal;
  final int? refundableAmount;
  final int? giftCardTotal;
  final int? giftCardTaxTotal;

  final Map<String, dynamic>? metadata;
  final String? salesChannelId;
  final String? shippingAddressId;
  final String? billingAddressId; // From Apidog schema
  final String? customerId;
  final String? paymentId; // From Apidog schema
  final String? idempotencyKey; // From Apidog schema
  final String? type; // Cart type e.g. "default", "swap" - From Apidog schema

  // Nested Objects
  final Address? shippingAddress;
  final Address? billingAddress;
  final Region? region; // Using the one defined for recent JSON
  final CustomerPlaceholder? customer; // From Apidog schema
  final PaymentPlaceholder? payment; // From Apidog schema
  final PaymentSessionPlaceholder? paymentSession; // Single object - From Apidog schema
  final SalesChannelPlaceholder? salesChannel; // From Apidog schema
  final Map<String, dynamic>? context; // For IP, user_agent - From Apidog schema

  // Lists
  final List<LineItem> items;
  final List shippingMethods;
  final List creditLines; // From recent JSON
  final List promotions; // From recent JSON
  final List<DiscountPlaceholder> discounts; // From Apidog schema
  final List<GiftCardPlaceholder> giftCards; // From Apidog schema
  final List<PaymentSessionPlaceholder> paymentSessions; // List of sessions - From Apidog schema

  Cart({
    required this.id,
    this.currencyCode,
    this.email,
    this.regionId,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.deletedAt,
    this.paymentAuthorizedAt,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.shippingTotal,
    this.discountSubtotal,
    this.discountTaxTotal,
    this.originalTotal,
    this.originalTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.originalItemTotal,
    this.originalItemSubtotal,
    this.originalItemTaxTotal,
    this.shippingSubtotal,
    this.shippingTaxTotal,
    this.originalShippingTaxTotal,
    this.originalShippingSubtotal,
    this.originalShippingTotal,
    this.creditLineSubtotal,
    this.creditLineTaxTotal,
    this.creditLineTotal,
    this.rawDiscountTotal,
    this.refundedTotal,
    this.refundableAmount,
    this.giftCardTotal,
    this.giftCardTaxTotal,
    this.metadata,
    this.salesChannelId,
    this.shippingAddressId,
    this.billingAddressId,
    this.customerId,
    this.paymentId,
    this.idempotencyKey,
    this.type,
    this.shippingAddress,
    this.billingAddress,
    this.region,
    this.customer,
    this.payment,
    this.paymentSession,
    this.salesChannel,
    this.context,
    required this.items,
    required this.shippingMethods,
    required this.creditLines,
    required this.promotions,
    required this.discounts,
    required this.giftCards,
    required this.paymentSessions,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final cartData = json['cart'] as Map<String, dynamic>?; // Make cartData itself potentially null
    if (cartData == null) {
      // If 'cart' key is missing, try to use the json directly (assuming it might be the cart object itself)
      // This provides flexibility if the top "cart" wrapper is sometimes absent.
      // However, if 'id' is still not found, then it's an issue.
      if (json['id'] == null) {
        throw Exception("Cart data is missing or malformed in response");
      }
      // Use json directly as cartData if 'cart' key is missing but 'id' is present
      return _parseCartData(json);
    }
    return _parseCartData(cartData);
  }

  static Cart _parseCartData(Map<String, dynamic> cartData) { // Helper to parse the actual cart content
    return Cart(
      id: cartData['id'] as String,
      currencyCode: cartData['currency_code'] as String?,
      email: cartData['email'] as String?,
      regionId: cartData['region_id'] as String?,
      createdAt: parseDateTime(cartData['created_at'] as String?),
      updatedAt: parseDateTime(cartData['updated_at'] as String?),
      completedAt: parseDateTime(cartData['completed_at'] as String?),
      deletedAt: parseDateTime(cartData['deleted_at'] as String?),
      paymentAuthorizedAt: parseDateTime(cartData['payment_authorized_at'] as String?),

      total: parseInt(cartData['total']),
      subtotal: parseInt(cartData['subtotal']),
      taxTotal: parseInt(cartData['tax_total']),
      discountTotal: parseInt(cartData['discount_total']),
      shippingTotal: parseInt(cartData['shipping_total']),

      discountSubtotal: parseInt(cartData['discount_subtotal']),
      discountTaxTotal: parseInt(cartData['discount_tax_total']),
      originalTotal: parseInt(cartData['original_total']),
      originalTaxTotal: parseInt(cartData['original_tax_total']),
      itemTotal: parseInt(cartData['item_total']),
      itemSubtotal: parseInt(cartData['item_subtotal']),
      itemTaxTotal: parseInt(cartData['item_tax_total']),
      originalItemTotal: parseInt(cartData['original_item_total']),
      originalItemSubtotal: parseInt(cartData['original_item_subtotal']),
      originalItemTaxTotal: parseInt(cartData['original_item_tax_total']),
      shippingSubtotal: parseInt(cartData['shipping_subtotal']),
      shippingTaxTotal: parseInt(cartData['shipping_tax_total']),
      originalShippingTaxTotal: parseInt(cartData['original_shipping_tax_total']),
      originalShippingSubtotal: parseInt(cartData['original_shipping_subtotal']),
      originalShippingTotal: parseInt(cartData['original_shipping_total']),
      creditLineSubtotal: parseInt(cartData['credit_line_subtotal']),
      creditLineTaxTotal: parseInt(cartData['credit_line_tax_total']),
      creditLineTotal: parseInt(cartData['credit_line_total']),

      rawDiscountTotal: parseInt(cartData['raw_discount_total']),
      refundedTotal: parseInt(cartData['refunded_total']),
      refundableAmount: parseInt(cartData['refundable_amount']),
      giftCardTotal: parseInt(cartData['gift_card_total']),
      giftCardTaxTotal: parseInt(cartData['gift_card_tax_total']),

      metadata: cartData['metadata'] != null ? Map<String, dynamic>.from(cartData['metadata']) : null,
      salesChannelId: cartData['sales_channel_id'] as String?,
      shippingAddressId: cartData['shipping_address_id'] as String?,
      billingAddressId: cartData['billing_address_id'] as String?,
      customerId: cartData['customer_id'] as String?,
      paymentId: cartData['payment_id'] as String?,
      idempotencyKey: cartData['idempotency_key'] as String?,
      type: cartData['type'] as String?,

      shippingAddress: cartData['shipping_address'] != null
          ? Address.fromJson(cartData['shipping_address'] as Map<String, dynamic>)
          : null,
      billingAddress: cartData['billing_address'] != null
          ? Address.fromJson(cartData['billing_address'] as Map<String, dynamic>)
          : null,
      region: cartData['region'] != null
          ? Region.fromJson(cartData['region'] as Map<String, dynamic>)
          : null,
      customer: cartData['customer'] != null
          ? CustomerPlaceholder.fromJson(cartData['customer'] as Map<String, dynamic>)
          : null,
      payment: cartData['payment'] != null
          ? PaymentPlaceholder.fromJson(cartData['payment'] as Map<String, dynamic>)
          : null,
      paymentSession: cartData['payment_session'] != null
          ? PaymentSessionPlaceholder.fromJson(cartData['payment_session'] as Map<String, dynamic>)
          : null,
      salesChannel: cartData['sales_channel'] != null
          ? SalesChannelPlaceholder.fromJson(cartData['sales_channel'] as Map<String, dynamic>)
          : null,
      context: cartData['context'] != null ? Map<String, dynamic>.from(cartData['context']) : null,

      items: (cartData['items'] as List<dynamic>? ?? [])
          .map((itemJson) => LineItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
      shippingMethods: cartData['shipping_methods'] as List<dynamic>? ?? [],
      creditLines: cartData['credit_lines'] as List<dynamic>? ?? [],
      promotions: cartData['promotions'] as List<dynamic>? ?? [],
      discounts: (cartData['discounts'] as List<dynamic>? ?? [])
          .map((dJson) => DiscountPlaceholder.fromJson(dJson as Map<String, dynamic>))
          .toList(),
      giftCards: (cartData['gift_cards'] as List<dynamic>? ?? [])
          .map((gcJson) => GiftCardPlaceholder.fromJson(gcJson as Map<String, dynamic>))
          .toList(),
      paymentSessions: (cartData['payment_sessions'] as List<dynamic>? ?? []) // Note: 'payment_sessions' (plural) for the list
          .map((psJson) => PaymentSessionPlaceholder.fromJson(psJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Cart copyWith({
    String? id,
    String? currencyCode,
    String? email,
    String? regionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? deletedAt,
    DateTime? paymentAuthorizedAt,
    int? total,
    int? subtotal,
    int? taxTotal,
    int? discountTotal,
    int? shippingTotal,
    int? discountSubtotal,
    int? discountTaxTotal,
    int? originalTotal,
    int? originalTaxTotal,
    int? itemTotal,
    int? itemSubtotal,
    int? itemTaxTotal,
    int? originalItemTotal,
    int? originalItemSubtotal,
    int? originalItemTaxTotal,
    int? shippingSubtotal,
    int? shippingTaxTotal,
    int? originalShippingTaxTotal,
    int? originalShippingSubtotal,
    int? originalShippingTotal,
    int? creditLineSubtotal,
    int? creditLineTaxTotal,
    int? creditLineTotal,
    int? rawDiscountTotal,
    int? refundedTotal,
    int? refundableAmount,
    int? giftCardTotal,
    int? giftCardTaxTotal,
    Map<String, dynamic>? metadata,
    String? salesChannelId,
    String? shippingAddressId,
    String? billingAddressId,
    String? customerId,
    String? paymentId,
    String? idempotencyKey,
    String? type,
    Address? shippingAddress,
    Address? billingAddress,
    Region? region,
    CustomerPlaceholder? customer,
    PaymentPlaceholder? payment,
    PaymentSessionPlaceholder? paymentSession,
    SalesChannelPlaceholder? salesChannel,
    Map<String, dynamic>? context,
    List<LineItem>? items,
    List? shippingMethods,
    List? creditLines,
    List? promotions,
    List<DiscountPlaceholder>? discounts,
    List<GiftCardPlaceholder>? giftCards,
    List<PaymentSessionPlaceholder>? paymentSessions,
  }) {
    return Cart(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
      email: email ?? this.email,
      regionId: regionId ?? this.regionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      paymentAuthorizedAt: paymentAuthorizedAt ?? this.paymentAuthorizedAt,
      total: total ?? this.total,
      subtotal: subtotal ?? this.subtotal,
      taxTotal: taxTotal ?? this.taxTotal,
      discountTotal: discountTotal ?? this.discountTotal,
      shippingTotal: shippingTotal ?? this.shippingTotal,
      discountSubtotal: discountSubtotal ?? this.discountSubtotal,
      discountTaxTotal: discountTaxTotal ?? this.discountTaxTotal,
      originalTotal: originalTotal ?? this.originalTotal,
      originalTaxTotal: originalTaxTotal ?? this.originalTaxTotal,
      itemTotal: itemTotal ?? this.itemTotal,
      itemSubtotal: itemSubtotal ?? this.itemSubtotal,
      itemTaxTotal: itemTaxTotal ?? this.itemTaxTotal,
      originalItemTotal: originalItemTotal ?? this.originalItemTotal,
      originalItemSubtotal: originalItemSubtotal ?? this.originalItemSubtotal,
      originalItemTaxTotal: originalItemTaxTotal ?? this.originalItemTaxTotal,
      shippingSubtotal: shippingSubtotal ?? this.shippingSubtotal,
      shippingTaxTotal: shippingTaxTotal ?? this.shippingTaxTotal,
      originalShippingTaxTotal: originalShippingTaxTotal ?? this.originalShippingTaxTotal,
      originalShippingSubtotal: originalShippingSubtotal ?? this.originalShippingSubtotal,
      originalShippingTotal: originalShippingTotal ?? this.originalShippingTotal,
      creditLineSubtotal: creditLineSubtotal ?? this.creditLineSubtotal,
      creditLineTaxTotal: creditLineTaxTotal ?? this.creditLineTaxTotal,
      creditLineTotal: creditLineTotal ?? this.creditLineTotal,
      rawDiscountTotal: rawDiscountTotal ?? this.rawDiscountTotal,
      refundedTotal: refundedTotal ?? this.refundedTotal,
      refundableAmount: refundableAmount ?? this.refundableAmount,
      giftCardTotal: giftCardTotal ?? this.giftCardTotal,
      giftCardTaxTotal: giftCardTaxTotal ?? this.giftCardTaxTotal,
      metadata: metadata ?? this.metadata,
      salesChannelId: salesChannelId ?? this.salesChannelId,
      shippingAddressId: shippingAddressId ?? this.shippingAddressId,
      billingAddressId: billingAddressId ?? this.billingAddressId,
      customerId: customerId ?? this.customerId,
      paymentId: paymentId ?? this.paymentId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      type: type ?? this.type,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      region: region ?? this.region,
      customer: customer ?? this.customer,
      payment: payment ?? this.payment,
      paymentSession: paymentSession ?? this.paymentSession,
      salesChannel: salesChannel ?? this.salesChannel,
      context: context ?? this.context,
      items: items ?? this.items,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      creditLines: creditLines ?? this.creditLines,
      promotions: promotions ?? this.promotions,
      discounts: discounts ?? this.discounts,
      giftCards: giftCards ?? this.giftCards,
      paymentSessions: paymentSessions ?? this.paymentSessions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency_code': currencyCode,
      'email': email,
      'region_id': regionId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'payment_authorized_at': paymentAuthorizedAt?.toIso8601String(),

      'total': total,
      'subtotal': subtotal,
      'tax_total': taxTotal,
      'discount_total': discountTotal,
      'shipping_total': shippingTotal,

      'discount_subtotal': discountSubtotal,
      'discount_tax_total': discountTaxTotal,
      'original_total': originalTotal,
      'original_tax_total': originalTaxTotal,
      'item_total': itemTotal,
      'item_subtotal': itemSubtotal,
      'item_tax_total': itemTaxTotal,
      'original_item_total': originalItemTotal,
      'original_item_subtotal': originalItemSubtotal,
      'original_item_tax_total': originalItemTaxTotal,
      'shipping_subtotal': shippingSubtotal,
      'shipping_tax_total': shippingTaxTotal,
      'original_shipping_tax_total': originalShippingTaxTotal,
      'original_shipping_subtotal': originalShippingSubtotal,
      'original_shipping_total': originalShippingTotal,
      'credit_line_subtotal': creditLineSubtotal,
      'credit_line_tax_total': creditLineTaxTotal,
      'credit_line_total': creditLineTotal,

      'raw_discount_total': rawDiscountTotal,
      'refunded_total': refundedTotal,
      'refundable_amount': refundableAmount,
      'gift_card_total': giftCardTotal,
      'gift_card_tax_total': giftCardTaxTotal,

      'metadata': metadata,
      'sales_channel_id': salesChannelId,
      'shipping_address_id': shippingAddressId,
      'billing_address_id': billingAddressId,
      'customer_id': customerId,
      'payment_id': paymentId,
      'idempotency_key': idempotencyKey,
      'type': type,

      'shipping_address': shippingAddress?.toJson(),
      'billing_address': billingAddress?.toJson(),
      'region': region?.toJson(),
      'customer': customer?.toJson(),
      'payment': payment?.toJson(),
      'payment_session': paymentSession?.toJson(),
      'sales_channel': salesChannel?.toJson(),
      'context': context,

      'items': items.map((item) => item.toJson()).toList(),
      'shipping_methods': shippingMethods,
      'credit_lines': creditLines,
      'promotions': promotions,
      'discounts': discounts.map((d) => d.toJson()).toList(),
      'gift_cards': giftCards.map((gc) => gc.toJson()).toList(),
      'payment_sessions': paymentSessions.map((ps) => ps.toJson()).toList(),
    };
  }




  @override
  String toString() {
    return 'Cart{id: $id, currencyCode: $currencyCode, email: $email, regionId: $regionId, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, deletedAt: $deletedAt, paymentAuthorizedAt: $paymentAuthorizedAt, total: $total, subtotal: $subtotal, taxTotal: $taxTotal, discountTotal: $discountTotal, shippingTotal: $shippingTotal, discountSubtotal: $discountSubtotal, discountTaxTotal: $discountTaxTotal, originalTotal: $originalTotal, originalTaxTotal: $originalTaxTotal, itemTotal: $itemTotal, itemSubtotal: $itemSubtotal, itemTaxTotal: $itemTaxTotal, originalItemTotal: $originalItemTotal, originalItemSubtotal: $originalItemSubtotal, originalItemTaxTotal: $originalItemTaxTotal, shippingSubtotal: $shippingSubtotal, shippingTaxTotal: $shippingTaxTotal, originalShippingTaxTotal: $originalShippingTaxTotal, originalShippingSubtotal: $originalShippingSubtotal, originalShippingTotal: $originalShippingTotal, creditLineSubtotal: $creditLineSubtotal, creditLineTaxTotal: $creditLineTaxTotal, creditLineTotal: $creditLineTotal, rawDiscountTotal: $rawDiscountTotal, refundedTotal: $refundedTotal, refundableAmount: $refundableAmount, giftCardTotal: $giftCardTotal, giftCardTaxTotal: $giftCardTaxTotal, metadata: $metadata, salesChannelId: $salesChannelId, shippingAddressId: $shippingAddressId, billingAddressId: $billingAddressId, customerId: $customerId, paymentId: $paymentId, idempotencyKey: $idempotencyKey, type: $type, shippingAddress: $shippingAddress, billingAddress: $billingAddress, region: $region, customer: $customer, payment: $payment, paymentSession: $paymentSession, salesChannel: $salesChannel, context: $context, items: $items, shippingMethods: $shippingMethods, creditLines: $creditLines, promotions: $promotions, discounts: $discounts, giftCards: $giftCards, paymentSessions: $paymentSessions}';
  }
}