import 'country_in_region_model.dart';

class Region {
  final String id;
  final String name;
  final String currencyCode;
  final bool automaticTaxes;
  final List<CountryInRegion> countries;
  // Other fields like tax_rate, providers, etc., might appear here in fuller responses.
  // Add them if needed based on more complete data.

  Region({
    required this.id,
    required this.name,
    required this.currencyCode,
    required this.automaticTaxes,
    required this.countries,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'] as String,
      name: json['name'] as String,
      currencyCode: json['currency_code'] as String,
      automaticTaxes: json['automatic_taxes'] as bool? ?? false,
      countries: (json['countries'] as List<dynamic>? ?? [])
          .map((countryJson) => CountryInRegion.fromJson(countryJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency_code': currencyCode,
      'automatic_taxes': automaticTaxes,
      'countries': countries.map((country) => country.toJson()).toList(),
    };
  }
}