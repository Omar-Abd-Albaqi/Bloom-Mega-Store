class Address {
  final String id;
  final String addressName;
  final bool isDefaultShipping;
  final bool isDefaultBilling;
  final String customerId;
  final String? company;
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;
  final String? city;
  final String? countryCode;
  final String? province;
  final String? postalCode;
  final String? phone;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Address({
    required this.id,
    required this.addressName,
    required this.isDefaultShipping,
    required this.isDefaultBilling,
    required this.customerId,
    this.company,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.phone,
    required this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? '',
      addressName: json['address_name'] ?? '',
      isDefaultShipping: json['is_default_shipping'] ?? false,
      isDefaultBilling: json['is_default_billing'] ?? false,
      customerId: json['customer_id'] ?? '',
      company: json['company'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      address1: json['address_1'],
      address2: json['address_2'],
      city: json['city'],
      countryCode: json['country_code'],
      province: json['province'],
      postalCode: json['postal_code'],
      phone: json['phone'],
      metadata: json['metadata'] ?? {},
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

}
