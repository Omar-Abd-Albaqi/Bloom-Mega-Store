import 'package:flutter/material.dart';
import '../../utils/api_manager.dart';

import '../../models/local_storage_models/product_model/product_model.dart';
class ProductListProvider with ChangeNotifier{
  List<ProductModel>? products;

  Future<void> getCategoryProductsList(String catId) async {
    products = null;
    Map<String, String> params = {
      "limit" : "20",
      "region_id":"reg_01JK96E8Y9KM1Y14S916J0KJKC",
      "category_id" : catId};
    print(params);
    products = await ApiManager.getProductsList(params);
    print(products);
    notifyListeners();
  }
}