import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    // Open the box after registering all adapters
    await Hive.openBox("bloom_hive_box");
  }

  static Future<void> addProductToFavorite(ProductModel product) async {
    final box = Hive.box<ProductModel>('favorites');
    await box.put(product.id, product); // Keyed by product ID
  }


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


  static Future<void> closeHiveBox() async {
    if (Hive.isBoxOpen("bloom_hive_box")) {
      await Hive.close();
    }
    return;
  }

  static bool isFirstTimeLaunch() =>
      hiveBox.get('isFirstTime', defaultValue: true) ?? true;

  static String getToken() =>
      hiveBox.get('token', defaultValue: null);


  static void setToken(String value) {
    hiveBox.put('token', value);
  }


  static void setFirstTime(bool value) {
    hiveBox.put('isFirstTime', value);
  }

  static void setLocale(bool value) {
    hiveBox.put('locale', value);
  }


  static String getCurrentRoute() =>
      hiveBox.get('route');

  static String getCurrentLocal() =>
      hiveBox.get('locale', defaultValue: "en") ?? "en";


}