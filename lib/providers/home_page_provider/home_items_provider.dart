import 'package:flutter/material.dart';

import '../../utils/api_manager.dart';

class HomeItemsProvider with ChangeNotifier{

List<dynamic> homeModels = [];
  
  Future getHomePageItems(BuildContext context) async {
    homeModels = await ApiManager.getHomeItems();
    notifyListeners();
  }

}