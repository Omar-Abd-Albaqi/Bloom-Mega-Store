import 'package:bloom/models/cart_models/region_model.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../models/home_items_models/collection_model.dart';
import '../../utils/api_manager.dart';

class CategoryProvider with ChangeNotifier{
  List<CategoryModel> categories = [];
  List<List<CategoryModel>> subCategories = [];
  List<CategoryModel> allSubCats = [];
  List<CategoryModel> filteredSubCats = [];
  List<Region> regions = [];

  int selectedCat = 0;

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
    print(filteredSubCats.length);
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