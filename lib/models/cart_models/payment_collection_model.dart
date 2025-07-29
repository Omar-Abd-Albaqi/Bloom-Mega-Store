class PaymentCollection {
  final String id;
  final String currencyCode;
  final int amount;
  final List<PaymentSession> paymentSessions;

  PaymentCollection({
    required this.id,
    required this.currencyCode,
    required this.amount,
    required this.paymentSessions,
  });

  factory PaymentCollection.fromJson(Map<String, dynamic> json) {
    return PaymentCollection(
      id: json['id'],
      currencyCode: json['currency_code'],
      amount: json['amount'],
      paymentSessions: (json['payment_sessions'] as List<dynamic>)
          .map((e) => PaymentSession.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency_code': currencyCode,
      'amount': amount,
      'payment_sessions': paymentSessions.map((e) => e.toJson()).toList(),
    };
  }
}

class PaymentSession {
  final String id;
  final String currencyCode;
  final String providerId;
  final Map<String, dynamic> data;
  final Map<String, dynamic> context;
  final String status;
  final DateTime? authorizedAt;
  final String paymentCollectionId;
  final Map<String, dynamic>? metadata;
  final RawAmount rawAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int amount;

  PaymentSession({
    required this.id,
    required this.currencyCode,
    required this.providerId,
    required this.data,
    required this.context,
    required this.status,
    required this.authorizedAt,
    required this.paymentCollectionId,
    this.metadata,
    required this.rawAmount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.amount,
  });

  factory PaymentSession.fromJson(Map<String, dynamic> json) {
    return PaymentSession(
      id: json['id'],
      currencyCode: json['currency_code'],
      providerId: json['provider_id'],
      data: Map<String, dynamic>.from(json['data'] ?? {}),
      context: Map<String, dynamic>.from(json['context'] ?? {}),
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,

      status: json['status'],
      authorizedAt: json['authorized_at'] != null
          ? DateTime.parse(json['authorized_at'])
          : null,
      paymentCollectionId: json['payment_collection_id'],
      rawAmount: RawAmount.fromJson(json['raw_amount']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency_code': currencyCode,
      'provider_id': providerId,
      'data': data,
      'context': context,
      'status': status,
      'authorized_at': authorizedAt?.toIso8601String(),
      'payment_collection_id': paymentCollectionId,
      'metadata': metadata,
      'raw_amount': rawAmount.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'amount': amount,
    };
  }
}

class RawAmount {
  final String value;
  final int precision;

  RawAmount({
    required this.value,
    required this.precision,
  });

  factory RawAmount.fromJson(Map<String, dynamic> json) {
    return RawAmount(
      value: json['value'],
      precision: json['precision'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'precision': precision,
    };
  }
}
