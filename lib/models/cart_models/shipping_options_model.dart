class ShippingOption {
  final String id;
  final String name;
  final String priceType;
  final int amount;
  final String providerId;
  final String? serviceZoneCity;
  final String? serviceZoneProvince;
  final String? serviceZoneCountry;

  ShippingOption({
    required this.id,
    required this.name,
    required this.priceType,
    required this.amount,
    required this.providerId,
    this.serviceZoneCity,
    this.serviceZoneProvince,
    this.serviceZoneCountry,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) {
    final location = json['service_zone']?['fulfillment_set']?['location']?['address'];
    return ShippingOption(
      id: json['id'],
      name: json['name'],
      priceType: json['price_type'],
      amount: json['amount'] ?? 0,
      providerId: json['provider_id'],
      serviceZoneCity: location?['city'],
      serviceZoneProvince: location?['province'],
      serviceZoneCountry: location?['country_code'],
    );
  }
}
