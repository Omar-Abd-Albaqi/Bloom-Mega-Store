import 'package:bloom/api/auth_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/api_manager.dart';
import '../../utils/hive_manager.dart';
import '../../utils/pop_ups.dart';

import '../../route/route_constants.dart';
import '../home_page_provider/home_items_provider.dart';
class LoginProvider with ChangeNotifier{
  String email = "";
  String password = "";

  bool loginLoading = false;
  bool showPass = false;



  toggleShowPass(){
    showPass =!showPass;
    notifyListeners();
  }


  setLoginLoading(bool value){
    loginLoading = value;
    notifyListeners();
  }


  Future<void> login (BuildContext context) async {
    setLoginLoading(true);

    Map<String, String>body = {
      'email': email,
      'password': password
    };
    Map<String, String> headers = {'Content-Type': 'application/json'};
    
    try{
      String token = await AuthApiManager.authenticateCustomer(body);
      HiveStorageManager.setToken(token);
      HiveStorageManager.setSignedIn(true);
      setLoginLoading(false);
      if(context.mounted){
        context.read<HomeItemsProvider>().getHomePageItems(context);
        Navigator.pushNamedAndRemoveUntil(
            context,
            entryPointScreenRoute,
            ModalRoute.withName(logInScreenRoute));
      }
    } catch (e){
      setLoginLoading(false);
      if(context.mounted){
        PopUps.apiError(context, e.toString());
      }
    }

  }
}