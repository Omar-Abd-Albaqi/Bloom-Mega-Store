
// This line assumes your file is named 'address_model.dart'
// You will need to run: flutter pub run build_runner build
import 'package:hive_flutter/adapters.dart';

part 'address_model.g.dart';

@HiveType(typeId: 8)
class Address extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? firstName;

  @HiveField(2)
  final String? lastName;

  @HiveField(3)
  final String? company;

  @HiveField(4)
  final String? address1;

  @HiveField(5)
  final String? address2;

  @HiveField(6)
  final String? city;

  @HiveField(7)
  final String? postalCode;

  @HiveField(8)
  final String countryCode;

  @HiveField(9)
  final String? province;

  @HiveField(10)
  final String? phone;

  // @HiveField(11) // Optional: if you use metadata and it's Hive-compatible
  // final Map<String, dynamic>? metadata;

  Address({
    required this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postalCode,
    required this.countryCode,
    this.province,
    this.phone,
    // this.metadata,
  });

  // Factory constructor for creating an Address from JSON (e.g., Medusa's response)
  // This remains unchanged as it's for API interaction, not Hive.
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      company: json['company'] as String?,
      address1: json['address_1'] as String?,
      address2: json['address_2'] as String?,
      city: json['city'] as String?,
      postalCode: json['postal_code'] as String?,
      countryCode: json['country_code'] as String,
      province: json['province'] as String?,
      phone: json['phone'] as String?,
      // metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  // toJson method for sending data to Medusa (for create or update operations)
  // This remains unchanged.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postal_code': postalCode,
      'country_code': countryCode,
      'province': province,
      'phone': phone,
      // 'metadata': metadata,
    };
    data.removeWhere((key, value) => value == null && key != 'address_2' && key != 'company' && key != 'province' && key != 'phone');
    return data;
  }

  // copyWith method to create a new instance with updated fields
  // This remains unchanged.
  Address copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? postalCode,
    String? countryCode,
    String? province,
    String? phone,
    // Map<String, dynamic>? metadata,
  }) {
    return Address(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      countryCode: countryCode ?? this.countryCode,
      province: province ?? this.province,
      phone: phone ?? this.phone,
      // metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() {
    return 'Address{id: $id, firstName: $firstName, lastName: $lastName, company: $company, address1: $address1, address2: $address2, city: $city, postalCode: $postalCode, countryCode: $countryCode, province: $province, phone: $phone}';
  }
}