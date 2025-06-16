import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/cart_models/address_model.dart';
import '../models/local_storage_models/product_model/product_model.dart';


class HiveStorageManager {
  static Box hiveBox = Hive.box("bloom_hive_box");

  static final ValueNotifier<bool> signedInNotifier = ValueNotifier<bool>(hiveBox.get('signedIn', defaultValue: false) ?? false);

  static void setSignedIn(bool value) {
    hiveBox.put('signedIn', value);
    signedInNotifier.value = value;
  }

  static Future<void> openHiveBox() async {
    await Hive.initFlutter();
    // Register your adapters here
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(ProductTypeAdapter());
    Hive.registerAdapter(ProductCollectionAdapter());
    Hive.registerAdapter(ProductOptionAdapter());
    Hive.registerAdapter(OptionValueAdapter());
    Hive.registerAdapter(ProductImageAdapter());
    Hive.registerAdapter(ProductVariantAdapter());
    Hive.registerAdapter(CalculatedPriceAdapter());
    await Hive.openBox<ProductModel>('favorites');
    await Hive.openBox<Address>('user_addresses');

    // Open the box after registering all adapters
    await Hive.openBox("bloom_hive_box");
  }

  static Future<void> addProductToFavorite(ProductModel product) async {
    final box = Hive.box<ProductModel>('favorites');
    await box.put(product.id, product); // Keyed by product ID
  }




  static Future<void> closeHiveBox() async {
    if (Hive.isBoxOpen("bloom_hive_box")) {
      await Hive.close();
    }
    return;
  }

  static void setToken(String value) {
    hiveBox.put('token', value);
  }

  static void setFirstTime(bool value) {
    hiveBox.put('isFirstTime', value);
  }

  static void setLocale(bool value) {
    hiveBox.put('locale', value);
  }

  static void setCartId(String newCartId) {
    hiveBox.put('cartId', newCartId);
  }

  static String getCurrentRoute() =>
      hiveBox.get('route');

  static String getCurrentLocal() =>
      hiveBox.get('locale', defaultValue: "en") ?? "en";

  static bool isFirstTimeLaunch() =>
      hiveBox.get('isFirstTime', defaultValue: true) ?? true;

  static String getToken() =>
      hiveBox.get('token', defaultValue: null);

  static String getCartId() =>
      hiveBox.get('cartId', defaultValue: "");



  /// Customer Addresses

  static Future<void> addOrUpdateAddress(Address address) async {
    final box = Hive.box<Address>('user_addresses');
    await box.put(address.id, address);
  }

  static Future<void> removeAddress(String addressId) async {
    final box = Hive.box<Address>('user_addresses');
    await box.delete(addressId);
  }

  static Future<List<Address>> getSavedAddresses({int limit = 0}) async {
    final box = Hive.box<Address>('user_addresses');
    List<Address> allAddresses = box.values.toList();

    if (limit > 0 && allAddresses.length > limit) {
      return allAddresses.take(limit).toList();
    }
    return allAddresses;
  }

  static Future<ValueListenable<Box<Address>>> addressBoxListenable() async {
    final box = Hive.box<Address>('user_addresses');
    return box.listenable();
  }

  //////////////////////////////////////////////////////////////////////////////

  /// Customer Favorites

  static Future<void> removeProductFromFavorite(String productId) async {
    final box = Hive.box<ProductModel>('favorites');
    await box.delete(productId);
  }

  static List<ProductModel> getFavoriteProducts({int limit = 4}) {
    final box = Hive.box<ProductModel>('favorites');

    // Get all the values from the box
    List<ProductModel> allFavorites = box.values.toList();

    // If there are fewer items than the limit, just return all
    if (allFavorites.length <= limit) {
      return allFavorites;
    }

    // If there are more, slice the list to get the last 'limit' items
    return allFavorites.take(limit).toList();
  }

  static bool isFavorite(String productId) {
    final box = Hive.box<ProductModel>('favorites');
    return box.containsKey(productId);
  }

  static ValueListenable<Box<ProductModel>> favoriteListenable() {
    return Hive.box<ProductModel>('favorites').listenable();
  }

  //////////////////////////////////////////////////////////////////////////////

}