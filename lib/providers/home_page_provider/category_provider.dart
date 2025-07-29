import 'package:bloom/models/cart_models/region_model.dart';
import 'package:bloom/models/home_items_models/main_models/products_categories.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../models/home_items_models/general_models/collection_model.dart';
import '../../models/local_storage_models/product_model/product_model.dart';
import '../../utils/api_manager.dart';

class CategoryProvider with ChangeNotifier{
  List<CategoryModel> categories = [];
  List<List<CategoryModel>> subCategories = [];
  List<CategoryModel> allSubCats = [];
  List<CategoryModel> filteredSubCats = [];
  List<Region> regions = [];


  List<ProductModel>? products;

  int selectedCat = 0;



  Future<void> getProduct({bool more = false}) async {
    products = null;
    Map<String, String> params = {
      "limit" : "20",
      "region_id":"reg_01JK96E8Y9KM1Y14S916J0KJKC",
      // "category_id" : catId,
    };
    products = await ApiManager.getProductsList(params);
    notifyListeners();
  }

  setSelectedCat(int index){
    selectedCat = index;
    notifyListeners();
  }

  List<CollectionModel> collections = [];


  getCollectionList()async {
    collections = await ApiManager.getCollectionList();
  }

  void filterSubCategories(String query) {
    final searchText = query.toLowerCase();

    filteredSubCats = query.isEmpty
        ? []
        : allSubCats.where((cat) => cat.name.toLowerCase().contains(searchText)).toList();
    notifyListeners();
  }

  List<CategoryModel> flattenCategoryLists(List<List<CategoryModel>> nestedLists) {
    return nestedLists.expand((list) => list).toList();
  }

  getCategories()async {
    List<CategoryModel> temp = await ApiManager.getCategories();
    categories = temp.where((element) => element.parentCategoryId == null).toList();
    temp.removeWhere((cat) => cat.parentCategoryId == null);
    for(var cat in categories){
      subCategories.add(temp.where((element) => element.parentCategoryId == cat.id).toList());
    }
    allSubCats = flattenCategoryLists(subCategories);
    // filteredSubCats = allSubCats;
    notifyListeners();
  }

  getRegions() async {
    regions = await ApiManager.getRegion();
  }
}