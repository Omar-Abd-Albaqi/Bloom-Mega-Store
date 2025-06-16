// --- New Basic Placeholder Models ---

import 'helper_functions.dart';

class CustomerPlaceholder {
  final String? id;
  final String? email;
  // Add other common customer fields if known, e.g., first_name, last_name
  final Map<String, dynamic> rawData; // To capture any other fields

  CustomerPlaceholder({this.id, this.email, required this.rawData});

  factory CustomerPlaceholder.fromJson(Map<String, dynamic> json) {
    return CustomerPlaceholder(
      id: json['id'] as String?,
      email: json['email'] as String?,
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => rawData;
}

class PaymentPlaceholder {
  final String? id;
  final int? amount;
  final String? currencyCode;
  // Add other common payment fields: provider_id, status, etc.
  final Map<String, dynamic> rawData;

  PaymentPlaceholder({this.id, this.amount, this.currencyCode, required this.rawData});

  factory PaymentPlaceholder.fromJson(Map<String, dynamic> json) {
    return PaymentPlaceholder(
      id: json['id'] as String?,
      amount: parseInt(json['amount']),
      currencyCode: json['currency_code'] as String?,
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => rawData;
}

class PaymentSessionPlaceholder {
  final String? id;
  final String? providerId;
  final int? amount;
  // Add other common payment session fields: status, data (object)
  final Map<String, dynamic> rawData;

  PaymentSessionPlaceholder({this.id, this.providerId, this.amount, required this.rawData});

  factory PaymentSessionPlaceholder.fromJson(Map<String, dynamic> json) {
    return PaymentSessionPlaceholder(
      id: json['id'] as String?,
      providerId: json['provider_id'] as String?,
      amount: parseInt(json['amount']), // Often payment sessions also have amount
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => rawData;
}

class SalesChannelPlaceholder {
  final String? id;
  final String? name;
  // Add other common sales channel fields: description, is_disabled
  final Map<String, dynamic> rawData;

  SalesChannelPlaceholder({this.id, this.name, required this.rawData});

  factory SalesChannelPlaceholder.fromJson(Map<String, dynamic> json) {
    return SalesChannelPlaceholder(
      id: json['id'] as String?,
      name: json['name'] as String?,
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => rawData;
}

class DiscountPlaceholder {
  final String? id;
  final String code;
  // Add other common discount fields: rule (object), regions (list)
  final Map<String, dynamic> rawData;

  DiscountPlaceholder({this.id, required this.code, required this.rawData});

  factory DiscountPlaceholder.fromJson(Map<String, dynamic> json) {
    return DiscountPlaceholder(
      id: json['id'] as String?,
      code: json['code'] as String? ?? 'N/A',
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => rawData;
}

class GiftCardPlaceholder {
  final String? id;
  final String code;
  final int? balance;
  // Add other common gift card fields: region_id, is_disabled
  final Map<String, dynamic> rawData;

  GiftCardPlaceholder({this.id, required this.code, this.balance, required this.rawData});

  factory GiftCardPlaceholder.fromJson(Map<String, dynamic> json) {
    return GiftCardPlaceholder(
      id: json['id'] as String?,
      code: json['code'] as String? ?? 'N/A',
      balance: parseInt(json['balance']),
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => rawData;
}