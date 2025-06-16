import 'dart:convert';

import 'package:bloom/models/cart_models/address_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

import '../../utils/api_manager.dart';
import '../../utils/pop_ups.dart';

List<Country> _parseCountries(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((e) => Country.fromJson(e)).toList();
}
List<StateModel> _parseStates(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((e) => StateModel.fromJson(e)).toList();
}
List<CityModel> _parseCities(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((e) => CityModel.fromJson(e)).toList();
}

class Country {
  final String id;
  final String name;
  final String phoneCode;
  final String emojiU;
  final String native;

  Country({
    required this.id,
    required this.name,
    required this.phoneCode,
    required this.emojiU,
    required this.native,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneCode: json['phoneCode'] ?? '',
      emojiU: json['emojiU'] ?? '',
      native: json['native'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneCode': phoneCode,
      'emojiU': emojiU,
      'native': native,
    };
  }

  /// Converts the emojiU string like "U+1F1E6 U+1F1EB" into actual emoji 🇦🇫
  String get emoji {
    try {
      return emojiU.split(' ').map((e) {
        final hexCode = e.replaceAll('U+', '');
        return String.fromCharCode(int.parse(hexCode, radix: 16));
      }).join();
    } catch (e) {
      return '';
    }
  }
}
class StateModel {
  final String id;
  final String name;
  final String stateCode;
  final String countryId;

  StateModel({
    required this.id,
    required this.name,
    required this.stateCode,
    required this.countryId,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      stateCode: json['stateCode'] ?? '',
      countryId: json['countryId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stateCode': stateCode,
      'countryId': countryId,
    };
  }
}
class CityModel {
  final String id;
  final String name;
  final String stateId;

  CityModel({
    required this.id,
    required this.name,
    required this.stateId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      stateId: json['stateId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stateId': stateId,
    };
  }
}



class AddressesProvider with ChangeNotifier {
  List<Address> addresses = [];


  //////////////////////////////////////////////////////////////////////////////
  List<Country> countries = [];
  List<StateModel> states = [];
  List<CityModel> cities = [];

  bool _isDataLoaded = false;
  bool get isDataLoaded => _isDataLoaded;

  Future<void> loadAllAddressData() async {
    if (_isDataLoaded) return;

    try {
      final countryString = await rootBundle.loadString('assets/json/countries.json');
      final stateString = await rootBundle.loadString('assets/json/states.json');
      final cityString = await rootBundle.loadString('assets/json/cities.json');

      // Parse in isolate using compute
      countries = await compute(_parseCountries, countryString);
      initFilteredCountries(countries);
      states = await compute(_parseStates, stateString);
      cities = await compute(_parseCities, cityString);

      _isDataLoaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading address data: $e');
    }
  }

  initFilteredCountries(List<Country> countries){
    filteredCountries = countries;
    notifyListeners();
  }
// top-level parser functions for compute


  // Optional: get states by country
  List<StateModel> getStatesByCountry(String countryId) =>
      states.where((s) => s.countryId == countryId).toList();

  // Optional: get cities by state
  List<CityModel> getCitiesByState(String stateId) =>
      cities.where((c) => c.stateId == stateId).toList();

  //////////////////////////////////////////////////////////////////////////////

  Country? selectedCountry;
  StateModel? selectedState;
  CityModel? selectedCity;

  List<StateModel> statesOfCountry = [];
  List<CityModel> citiesOfState = [];

  List<Country> filteredCountries = [];
  List<StateModel> filteredStates = [];
  List<CityModel> filteredCities = [];

  setCountry(Country? country){
    selectedCountryText = country?.name ?? "";
    selectedStateText = "";
    selectedCityText = "";
    selectedState = null;
    selectedCity = null;
    selectedCountry = country;
    statesOfCountry = country == null ? [] : getStatesByCountry(country.id);
    filteredStates = statesOfCountry;
    notifyListeners();
  }

  setState(StateModel? state){
    selectedStateText = state?.name ?? "";
    selectedCityText = "";
    selectedCity = null;
    selectedState = state;
    citiesOfState = state == null ? [] :  getCitiesByState(state.id);
    filteredCities = citiesOfState;
    notifyListeners();
  }

  setCity(CityModel? city){
    selectedCityText = city?.name ?? "";
    selectedCity = city;
    notifyListeners();
  }

  void filterCountries(String query) {
    filteredCountries = smartFilter(countries, query, (c) => c.name);
    notifyListeners();
  }

  void filterStates(String query) {
    filteredStates = smartFilter(statesOfCountry, query, (s) => s.name);
    notifyListeners();
  }

  void filterCities(String query) {
    filteredCities = smartFilter(citiesOfState, query, (c) => c.name);
    notifyListeners();
  }

  List<T> smartFilter<T>(
      List<T> list,
      String query,
      String Function(T item) getName,
      )
  {
    final queryLC = query.toLowerCase();

    var filtered = list.where((item) {
      return getName(item).toLowerCase().contains(queryLC);
    }).toList();

    filtered.sort((a, b) {
      final aNameLC = getName(a).toLowerCase();
      final bNameLC = getName(b).toLowerCase();

      final aStarts = aNameLC.startsWith(queryLC);
      final bStarts = bNameLC.startsWith(queryLC);

      if (aStarts && !bStarts) return -1;
      if (!aStarts && bStarts) return 1;
      return aNameLC.compareTo(bNameLC);
    });

    return filtered;
  }

  String firstName = "";
  String lastName = "";
  String selectedCountryText = "";
  String selectedStateText = "";
  String selectedCityText = "";
  String phoneNumber = "";
  String address1 = "";
  String postalCde = "";
  String address2 = "";
  String note = "";
  String street = "";
  String buildingNumber = "";

  setDataFromLocation(Placemark placeMark){
    setCountry(countries.firstWhereOrNull((country) => country.name.toLowerCase() == placeMark.country?.toLowerCase()));
    setState(states.firstWhereOrNull((state) => state.name.toLowerCase() == placeMark.administrativeArea?.toLowerCase()));
    setCity(cities.firstWhereOrNull((city) => city.name.toLowerCase() == (placeMark.locality ?? placeMark.subAdministrativeArea)));
    postalCde = placeMark.postalCode ?? "";
    street = placeMark.street ?? "";
    buildingNumber = placeMark.name ?? "";

    notifyListeners();
  }



   setFirstname(String value){
    firstName = value;
    print(firstName);
  }

  getAddresses(BuildContext context) async {
    try {
      addresses = await ApiManager.getAddresses();
      print(addresses);
    } catch (e) {
      if (context.mounted) {
        PopUps.apiError(context, e.toString());
      }
    }
  }
}
