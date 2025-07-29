import 'package:bloom/api/home_page_api_manager.dart';
import 'package:flutter/material.dart';

import '../../models/local_storage_models/product_model/product_model.dart';
import '../../utils/api_manager.dart';

class HomeItemsProvider with ChangeNotifier{

List<dynamic> homeModels = [];
 Map<String, List<ProductModel>> productsByCategory = {};
 Map<String, bool> categoryLoadings = {};

 Map<String, List<ProductModel>> productsByCollection = {};
 Map<String, bool> collectionLoadings = {};
  
  Future getHomePageItems(BuildContext context) async {
    homeModels = await HomePageApiManager.getHomeItems(context);
    notifyListeners();
  }

getProductListFromCategory( String catId) async {
    print("getting products from category");
  Map<String, String> params = {
    "limit" : "8",
    "region_id":"reg_01JK96E8Y9KM1Y14S916J0KJKC",
    "category_id" : catId};
  List<ProductModel> response =  await ApiManager.getProductsList(params);
  productsByCategory[catId] = response;
    print(productsByCategory[catId]?.length ?? 0);
  notifyListeners();
}

getProductListFromCollection( String collectionId) async {
  print("getting products from collection");
  Map<String, String> params = {
    "limit" : "8",
    "region_id":"reg_01JK96E8Y9KM1Y14S916J0KJKC",
    "collection_id" : collectionId};
  final response =  await ApiManager.getProductsList(params);
  productsByCollection[collectionId] = response;
  notifyListeners();
}

}