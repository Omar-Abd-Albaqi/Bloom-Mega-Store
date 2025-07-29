import '../cart_models/address_model.dart';

class CustomerDetailsModel {
  final String id;
  final String email;
  final String? defaultBillingAddressId;
  final String? defaultShippingAddressId;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final List<Address> addresses;
  final String? phone;
  final Map<String, dynamic>? additionalData;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  CustomerDetailsModel({
    required this.id,
    required this.email,
    this.defaultBillingAddressId,
    this.defaultShippingAddressId,
    this.companyName,
    this.firstName,
    this.lastName,
    required this.addresses,
    this.phone,
    this.additionalData,
    required this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      defaultBillingAddressId: json['default_billing_address_id'],
      defaultShippingAddressId: json['default_shipping_address_id'],
      companyName: json['company_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e))
          .toList() ??
          [],
      phone: json['phone'],
      additionalData: json['additional_data'] ?? {},
      metadata: json['metadata'] ?? {},
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
    );
  }


  Map<String, dynamic> toJsonForUpdate() {
    final Map<String, dynamic> data = {};

    if (email != null) data['email'] = email;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (companyName != null) data['company_name'] = companyName;
    if (phone != null) data['phone'] = phone;

    if (additionalData != null && additionalData!.isNotEmpty) {
      data['additional_data'] = additionalData;
    }

    if (metadata.isNotEmpty) {
      data['metadata'] = metadata;
    }

    return data;
  }

  @override
  String toString() {
    return 'CustomerDetailsModel{id: $id, email: $email, defaultBillingAddressId: $defaultBillingAddressId, defaultShippingAddressId: $defaultShippingAddressId, companyName: $companyName, firstName: $firstName, lastName: $lastName, addresses: $addresses, phone: $phone, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt}';
  }
}
